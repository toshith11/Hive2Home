"""
Module 2: Honey Production Prediction

Trains a small regression model on historical + simulated hive/production
data to predict expected yield (kg) for an upcoming harvest window. Falls
back to training-on-first-use with simulated data so this works standalone
before Member 4's real production history is available.
"""
from typing import List
import numpy as np
import pandas as pd
from sklearn.ensemble import GradientBoostingRegressor

from app.schemas import ProductionPredictRequest, ProductionPredictResponse
from app.utils.simulate_data import simulate_production_history

SEASON_MAP = {"spring": 0, "summer": 1, "monsoon": 2, "autumn": 3, "winter": 4}

_FEATURE_COLS = [
    "avg_health_score", "colony_strength_index", "season_code",
    "avg_temperature_c", "avg_humidity_pct", "forage_availability_index",
]

_model = None  # lazily trained singleton


def _get_model() -> GradientBoostingRegressor:
    global _model
    if _model is None:
        df = simulate_production_history(n_samples=800)
        df["season_code"] = df["season"].map(SEASON_MAP)
        X = df[_FEATURE_COLS]
        y = df["yield_kg"]
        model = GradientBoostingRegressor(random_state=42, n_estimators=200, max_depth=3)
        model.fit(X, y)
        _model = model
    return _model


def predict_production(req: ProductionPredictRequest) -> ProductionPredictResponse:
    model = _get_model()
    row = pd.DataFrame([{
        "avg_health_score": req.avg_health_score,
        "colony_strength_index": req.colony_strength_index,
        "season_code": SEASON_MAP[req.season],
        "avg_temperature_c": req.avg_temperature_c,
        "avg_humidity_pct": req.avg_humidity_pct,
        "forage_availability_index": req.forage_availability_index,
    }])

    pred = float(model.predict(row)[0])
    pred = max(pred, 0.0)

    # crude uncertainty band using the spread across the model's individual trees
    row_values = row[_FEATURE_COLS].values
    tree_preds = np.array([
        tree[0].predict(row_values)[0] for tree in model.estimators_
    ])
    std = float(tree_preds.std())
    low, high = max(pred - 1.5 * std, 0.0), pred + 1.5 * std

    drivers = []
    importances = dict(zip(_FEATURE_COLS, model.feature_importances_))
    top_drivers = sorted(importances.items(), key=lambda kv: kv[1], reverse=True)[:3]
    label_map = {
        "avg_health_score": "hive health score",
        "colony_strength_index": "colony strength",
        "season_code": "seasonal timing",
        "avg_temperature_c": "temperature conditions",
        "avg_humidity_pct": "humidity conditions",
        "forage_availability_index": "forage/flowering availability",
    }
    for feat, _ in top_drivers:
        drivers.append(label_map.get(feat, feat))

    return ProductionPredictResponse(
        hive_id=req.hive_id,
        predicted_yield_kg=round(pred, 2),
        confidence_range_kg=[round(low, 2), round(high, 2)],
        key_drivers=drivers,
    )
