"""
Module 3: AI Location Recommendation

Ranks candidate migratory-beekeeping locations using a transparent weighted
score across flowering/forage density, favourable weather, and historical
production performance. Weighted scoring (rather than a trained model) is
used deliberately here: there typically isn't enough real historical
migration-outcome data yet to train a model, and beekeepers benefit more
from an explainable "why this location" reason than a black-box rank.
"""
from typing import List
from app.schemas import LocationRecommendRequest, LocationRecommendResponse, LocationScore, CandidateLocation

_WEIGHTS = {
    "flowering": 0.45,
    "weather": 0.30,
    "history": 0.25,
}

# comfortable ranges for migratory apiary siting
_IDEAL_TEMP = (20.0, 32.0)
_IDEAL_HUMIDITY = (40.0, 70.0)
_MAX_COMFORTABLE_RAINFALL_MM = 60.0


def _weather_favourability(c: CandidateLocation) -> float:
    t_lo, t_hi = _IDEAL_TEMP
    h_lo, h_hi = _IDEAL_HUMIDITY

    temp_score = 1.0 if t_lo <= c.forecast_temp_c <= t_hi else max(
        0.0, 1 - (min(abs(c.forecast_temp_c - t_lo), abs(c.forecast_temp_c - t_hi)) / 15)
    )
    hum_score = 1.0 if h_lo <= c.forecast_humidity_pct <= h_hi else max(
        0.0, 1 - (min(abs(c.forecast_humidity_pct - h_lo), abs(c.forecast_humidity_pct - h_hi)) / 30)
    )
    rain_score = max(0.0, 1 - (c.forecast_rainfall_mm / (_MAX_COMFORTABLE_RAINFALL_MM * 2)))

    return round((temp_score + hum_score + rain_score) / 3, 3)


def _history_favourability(c: CandidateLocation, benchmark_yield: float) -> float:
    if c.historical_avg_yield_kg is None or benchmark_yield <= 0:
        return 0.5  # neutral prior when no data
    return round(min(c.historical_avg_yield_kg / benchmark_yield, 1.5) / 1.5, 3)


def recommend_locations(req: LocationRecommendRequest) -> LocationRecommendResponse:
    candidates = req.candidates
    known_yields = [c.historical_avg_yield_kg for c in candidates if c.historical_avg_yield_kg]
    benchmark_yield = max(known_yields) if known_yields else 0.0

    scored: List[LocationScore] = []
    for c in candidates:
        flowering = round(min(max(c.flowering_index, 0.0), 1.0), 3)
        weather = _weather_favourability(c)
        history = _history_favourability(c, benchmark_yield)

        score = (
            flowering * _WEIGHTS["flowering"]
            + weather * _WEIGHTS["weather"]
            + history * _WEIGHTS["history"]
        ) * 100

        # distance is a soft penalty, not part of the core score, since a
        # beekeeper may still choose a farther but much better site
        if c.distance_km:
            score -= min(c.distance_km / 50, 10)  # up to 10-point penalty for very far sites

        reasons = []
        if flowering >= 0.7:
            reasons.append("strong flowering/forage availability")
        elif flowering <= 0.3:
            reasons.append("weak forage availability")
        if weather >= 0.7:
            reasons.append("favourable weather forecast")
        elif weather <= 0.4:
            reasons.append("less favourable weather forecast")
        if history >= 0.8:
            reasons.append("strong historical yields in this area")
        elif history <= 0.4 and c.historical_avg_yield_kg is not None:
            reasons.append("below-average historical yields here")
        reason_text = ", ".join(reasons) if reasons else "moderate conditions across all factors"

        scored.append(LocationScore(name=c.name, score=round(score, 1), reason=reason_text.capitalize()))

    scored.sort(key=lambda s: s.score, reverse=True)
    return LocationRecommendResponse(beekeeper_id=req.beekeeper_id, ranked_locations=scored)
