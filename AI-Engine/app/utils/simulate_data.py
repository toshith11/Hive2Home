"""
Generates simulated hive/production data so Member 5 can build and demo
modules 1-3 without waiting on real IoT data or Member 4's production
history endpoint.
"""
import numpy as np
import pandas as pd

_SEASONS = ["spring", "summer", "monsoon", "autumn", "winter"]
# rough seasonal forage multipliers used only to make the simulated data
# internally consistent (spring/autumn = better flowering, monsoon = worse)
_SEASON_FORAGE_BIAS = {"spring": 0.8, "summer": 0.5, "monsoon": 0.3, "autumn": 0.75, "winter": 0.4}


def simulate_production_history(n_samples: int = 500, seed: int = 42) -> pd.DataFrame:
    rng = np.random.default_rng(seed)

    seasons = rng.choice(_SEASONS, size=n_samples)
    forage_bias = np.array([_SEASON_FORAGE_BIAS[s] for s in seasons])

    avg_health_score = np.clip(rng.normal(75, 15, n_samples), 0, 100)
    colony_strength_index = np.clip(rng.normal(0.6, 0.2, n_samples), 0, 1)
    forage_availability_index = np.clip(forage_bias + rng.normal(0, 0.1, n_samples), 0, 1)
    avg_temperature_c = np.clip(rng.normal(28, 5, n_samples), 10, 42)
    avg_humidity_pct = np.clip(rng.normal(55, 12, n_samples), 20, 95)

    # synthetic ground-truth yield: a plausible function of the above + noise
    yield_kg = (
        5
        + 0.25 * avg_health_score
        + 20 * colony_strength_index
        + 25 * forage_availability_index
        - 0.15 * np.abs(avg_temperature_c - 27)
        - 0.05 * np.abs(avg_humidity_pct - 55)
        + rng.normal(0, 4, n_samples)
    )
    yield_kg = np.clip(yield_kg, 0, None)

    return pd.DataFrame({
        "season": seasons,
        "avg_health_score": avg_health_score,
        "colony_strength_index": colony_strength_index,
        "forage_availability_index": forage_availability_index,
        "avg_temperature_c": avg_temperature_c,
        "avg_humidity_pct": avg_humidity_pct,
        "yield_kg": yield_kg,
    })


def simulate_sensor_readings(n_readings: int = 24, anomalous: bool = False, seed: int = 1):
    """Returns a list of dicts matching the SensorReading schema, useful for
    testing /hive-health/score without real IoT data."""
    rng = np.random.default_rng(seed)
    readings = []
    base_weight = 25.0
    for i in range(n_readings):
        temp = rng.normal(34, 1.0) if not anomalous else rng.normal(39, 2.0)
        hum = rng.normal(57, 4.0) if not anomalous else rng.normal(78, 5.0)
        weight = base_weight + (i * 0.02 if not anomalous else -i * 0.15) + rng.normal(0, 0.05)
        sound_rms = rng.normal(0.4, 0.05) if not anomalous else rng.normal(0.9, 0.1)
        sound_freq = rng.normal(250, 15) if not anomalous else rng.normal(400, 30)
        readings.append({
            "timestamp": f"2026-09-{(i % 28) + 1:02d}T{i % 24:02d}:00:00",
            "temperature_c": round(float(temp), 2),
            "humidity_pct": round(float(hum), 2),
            "weight_kg": round(float(weight), 3),
            "sound_rms": round(float(sound_rms), 3),
            "sound_freq_peak_hz": round(float(sound_freq), 1),
        })
    return readings
