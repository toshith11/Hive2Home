"""
Reference thresholds used by the AI engine.

IMPORTANT: The lab-quality figures below are TYPICAL honey-quality
benchmarks used widely in prototypes and are broadly aligned with common
FSSAI/Codex Alimentarius style limits. They are NOT pulled from a live,
current regulatory document. Before relying on this for anything beyond a
hackathon demo, cross-check against the current official FSSAI honey
standard and whatever lab format you're actually targeting.
"""

# ---------------------------------------------------------------------
# 1. Hive sensor "ideal" ranges (used by Hive Health Score)
# ---------------------------------------------------------------------
HIVE_IDEAL_RANGES = {
    "temperature_c": {"min": 32.0, "max": 36.0, "critical_low": 28.0, "critical_high": 40.0},
    "humidity_pct": {"min": 50.0, "max": 65.0, "critical_low": 35.0, "critical_high": 80.0},
    # weight is evaluated as a *rate of change* (kg/day), not an absolute band
    "weight_change_kg_per_day": {"min": -0.3, "max": 2.0},
    # sound is evaluated via an anomaly score (0 = normal, 1 = highly anomalous)
    "sound_anomaly_score": {"max_normal": 0.5},
}

# Weights used when combining sub-scores into the final Hive Health Score
HIVE_HEALTH_WEIGHTS = {
    "temperature": 0.30,
    "humidity": 0.20,
    "weight_trend": 0.30,
    "sound": 0.20,
}

# ---------------------------------------------------------------------
# 2. Honey lab-quality thresholds (used by Lab Report Analysis)
#    All limits are "must be within" for a PASS.
# ---------------------------------------------------------------------
LAB_QUALITY_STANDARDS = {
    "moisture": {"unit": "%", "max": 20.0,
                 "fail_reason": "Moisture above limit — usually caused by early/uncapped-frame harvesting, "
                                 "humid storage conditions, or insufficient dehydration before extraction."},
    "hmf": {"unit": "mg/kg", "max": 80.0,
            "fail_reason": "High HMF (hydroxymethylfurfural) — usually caused by overheating during processing/"
                            "extraction, prolonged storage, or storage in hot conditions."},
    "reducing_sugars": {"unit": "%", "min": 65.0,
                         "fail_reason": "Reducing sugar content below limit — may indicate adulteration with "
                                        "sucrose syrup or premature harvesting before nectar is fully converted."},
    "sucrose": {"unit": "%", "max": 5.0,
                "fail_reason": "Sucrose above limit — may indicate adulteration with sugar syrup or that bees "
                                "were fed sugar syrup close to harvest."},
    "ash": {"unit": "%", "max": 0.5,
            "fail_reason": "Ash content above limit — may indicate mineral contamination from processing "
                            "equipment or environmental contamination."},
    "diastase_activity": {"unit": "Schade units", "min": 8.0,
                           "fail_reason": "Low diastase activity — usually caused by excessive heating during "
                                          "processing/extraction or prolonged/hot storage, which degrades enzymes."},
    "fructose_glucose_ratio": {"unit": "ratio", "min": 0.9, "max": 1.4,
                                "fail_reason": "Fructose/glucose ratio outside normal range — may indicate "
                                                "adulteration or an atypical floral source."},
    "pesticide_residue": {"unit": "mg/kg", "max": 0.01,
                           "fail_reason": "Pesticide residue detected above limit — check for nearby agricultural "
                                          "spraying, contaminated forage sources, or treatment chemicals used in the apiary."},
    "antibiotic_residue": {"unit": "mg/kg", "max": 0.0,
                            "fail_reason": "Antibiotic residue detected — check any recent hive medication/"
                                            "treatment practices and withdrawal periods before harvest."},
}
