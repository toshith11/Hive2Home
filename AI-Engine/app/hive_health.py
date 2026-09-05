"""
Module 1: Hive Health Score

Combines temperature, humidity, weight trend and sound into a single
0-100 health score, plus human-readable flags for anything abnormal.

Approach: rule-based sub-scores (transparent, explainable, works with zero
training data) + a lightweight anomaly check on the sound signature using
an IsolationForest fitted on "normal" simulated samples. This is deliberately
NOT a black-box diagnosis — it's an early-warning / decision-support signal,
consistent with the product's stated positioning.
"""
from typing import List
import numpy as np

from app.schemas import SensorReading, HealthFlag, HiveHealthResponse
from app.reference_standards import HIVE_IDEAL_RANGES, HIVE_HEALTH_WEIGHTS


def _band_score(value: float, low: float, high: float, crit_low: float, crit_high: float) -> float:
    """Returns 0-100: 100 inside [low, high], degrading linearly to 0 at the critical bounds."""
    if low <= value <= high:
        return 100.0
    if value < low:
        if value <= crit_low:
            return 0.0
        return 100.0 * (value - crit_low) / (low - crit_low)
    # value > high
    if value >= crit_high:
        return 0.0
    return 100.0 * (crit_high - value) / (crit_high - high)


def _weight_trend_kg_per_day(readings: List[SensorReading]) -> float:
    if len(readings) < 2:
        return 0.0
    first, last = readings[0], readings[-1]
    # crude day-fraction estimate assuming evenly spaced readings; a real
    # implementation should parse timestamps properly
    n_intervals = max(len(readings) - 1, 1)
    total_change = last.weight_kg - first.weight_kg
    return total_change / n_intervals * 24  # assume ~hourly readings -> per-day rate


def _sound_anomaly_score(readings: List[SensorReading]) -> float:
    """0 = normal, 1 = highly anomalous.

    Uses a robust z-score (median absolute deviation) comparing the latest
    reading against the recent history, rather than IsolationForest with a
    fixed contamination rate. Contamination-based detection forces a fixed
    fraction of *any* batch to be labeled anomalous, even when the whole
    batch is uniform and genuinely normal -- a real false-positive found
    during testing. Z-score against the batch's own spread avoids that:
    uniform data has ~0 spread, so nothing gets flagged unless the latest
    reading is a genuine outlier.
    """
    if len(readings) < 5:
        return 0.0

    rms_values = np.array([r.sound_rms for r in readings])
    freq_values = np.array([r.sound_freq_peak_hz or 0.0 for r in readings])

    def robust_z(values: np.ndarray) -> float:
        median = np.median(values)
        mad = np.median(np.abs(values - median))
        if mad < 1e-9:
            return 0.0
        return abs((values[-1] - median) / (1.4826 * mad))

    z_rms = robust_z(rms_values)
    z_freq = robust_z(freq_values)
    combined_z = max(z_rms, z_freq)

    anomaly = float(np.clip((combined_z - 2) / 3, 0, 1))
    return anomaly


def compute_hive_health(hive_id: str, readings: List[SensorReading]) -> HiveHealthResponse:
    if not readings:
        raise ValueError("readings cannot be empty")

    latest = readings[-1]
    flags: List[HealthFlag] = []

    # --- Temperature ---
    t = HIVE_IDEAL_RANGES["temperature_c"]
    temp_score = _band_score(latest.temperature_c, t["min"], t["max"], t["critical_low"], t["critical_high"])
    if temp_score < 50:
        flags.append(HealthFlag(
            parameter="temperature",
            message=f"Brood-nest temperature {latest.temperature_c}°C is outside the healthy "
                    f"{t['min']}-{t['max']}°C range.",
            severity="critical" if temp_score < 20 else "alert",
        ))

    # --- Humidity ---
    h = HIVE_IDEAL_RANGES["humidity_pct"]
    hum_score = _band_score(latest.humidity_pct, h["min"], h["max"], h["critical_low"], h["critical_high"])
    if hum_score < 50:
        flags.append(HealthFlag(
            parameter="humidity",
            message=f"Hive humidity {latest.humidity_pct}% is outside the healthy "
                    f"{h['min']}-{h['max']}% range.",
            severity="critical" if hum_score < 20 else "alert",
        ))

    # --- Weight trend ---
    w = HIVE_IDEAL_RANGES["weight_change_kg_per_day"]
    trend = _weight_trend_kg_per_day(readings)
    if trend < w["min"]:
        weight_score = max(0.0, 100.0 * (1 - abs(trend - w["min"]) / 2))
        flags.append(HealthFlag(
            parameter="weight",
            message=f"Hive weight is dropping ({trend:.2f} kg/day) — could indicate absconding, "
                    f"robbing, or a nectar dearth.",
            severity="alert" if weight_score > 20 else "critical",
        ))
    elif trend > w["max"]:
        weight_score = 80.0  # rapid gain isn't dangerous, just flag as worth checking (possible swarm prep)
        flags.append(HealthFlag(
            parameter="weight",
            message=f"Hive weight is rising unusually fast ({trend:.2f} kg/day) — worth a manual check "
                    f"for swarming preparation or a scale calibration issue.",
            severity="watch",
        ))
    else:
        weight_score = 100.0

    # --- Sound anomaly ---
    anomaly = _sound_anomaly_score(readings)
    sound_score = 100.0 * (1 - anomaly)
    if anomaly > HIVE_IDEAL_RANGES["sound_anomaly_score"]["max_normal"]:
        flags.append(HealthFlag(
            parameter="sound",
            message="Bee sound pattern deviates from the recent baseline — could indicate queenlessness, "
                    "distress, or an external disturbance. Recommend manual inspection.",
            severity="alert" if anomaly < 0.8 else "critical",
        ))

    weights = HIVE_HEALTH_WEIGHTS
    health_score = round(
        temp_score * weights["temperature"]
        + hum_score * weights["humidity"]
        + weight_score * weights["weight_trend"]
        + sound_score * weights["sound"],
        1,
    )

    if health_score >= 80:
        status = "Healthy"
        recommendation = "Hive parameters look normal. No action needed."
    elif health_score >= 60:
        status = "Watch"
        recommendation = "Minor deviations detected. Keep monitoring; a routine check within a few days is enough."
    elif health_score >= 35:
        status = "Alert"
        recommendation = "Notable deviations detected. A manual hive inspection is recommended soon."
    else:
        status = "Critical"
        recommendation = "Multiple/severe deviations detected. Manual inspection recommended as soon as possible."

    return HiveHealthResponse(
        hive_id=hive_id,
        health_score=health_score,
        status=status,
        flags=flags,
        recommendation=recommendation,
    )
