from typing import List, Optional, Literal
from pydantic import BaseModel, Field


# ---------------------------------------------------------------------
# 1. Hive Health
# ---------------------------------------------------------------------
class SensorReading(BaseModel):
    timestamp: str
    temperature_c: float
    humidity_pct: float
    weight_kg: float
    sound_rms: float          # simple loudness/energy feature from MEMS mic
    sound_freq_peak_hz: Optional[float] = None


class HiveHealthRequest(BaseModel):
    hive_id: str
    readings: List[SensorReading] = Field(
        ..., description="Recent readings, ideally last 24-72h, oldest first."
    )


class HealthFlag(BaseModel):
    parameter: str
    message: str
    severity: Literal["watch", "alert", "critical"]


class HiveHealthResponse(BaseModel):
    hive_id: str
    health_score: float
    status: Literal["Healthy", "Watch", "Alert", "Critical"]
    flags: List[HealthFlag]
    recommendation: str


# ---------------------------------------------------------------------
# 2. Production Prediction
# ---------------------------------------------------------------------
class ProductionPredictRequest(BaseModel):
    hive_id: str
    avg_health_score: float
    colony_strength_index: float = Field(..., description="0-1, proxy from weight-gain trend")
    season: Literal["spring", "summer", "monsoon", "autumn", "winter"]
    avg_temperature_c: float
    avg_humidity_pct: float
    forage_availability_index: float = Field(..., description="0-1, flowering/forage density estimate")
    last_season_yield_kg: Optional[float] = None


class ProductionPredictResponse(BaseModel):
    hive_id: str
    predicted_yield_kg: float
    confidence_range_kg: List[float]
    key_drivers: List[str]


# ---------------------------------------------------------------------
# 3. Location Recommendation
# ---------------------------------------------------------------------
class CandidateLocation(BaseModel):
    name: str
    flowering_index: float = Field(..., description="0-1, forage/flowering density")
    forecast_temp_c: float
    forecast_humidity_pct: float
    forecast_rainfall_mm: float
    historical_avg_yield_kg: Optional[float] = None
    distance_km: Optional[float] = None


class LocationRecommendRequest(BaseModel):
    beekeeper_id: str
    current_location: str
    candidates: List[CandidateLocation]


class LocationScore(BaseModel):
    name: str
    score: float
    reason: str


class LocationRecommendResponse(BaseModel):
    beekeeper_id: str
    ranked_locations: List[LocationScore]


# ---------------------------------------------------------------------
# 4. Lab Report Analysis
# ---------------------------------------------------------------------
class LabParameterInput(BaseModel):
    parameters: dict = Field(
        ..., description="e.g. {'moisture': 21.3, 'hmf': 12.4, 'reducing_sugars': 68.2}"
    )
    batch_id: str


class ParameterResult(BaseModel):
    name: str
    value: float
    unit: str
    limit_description: str
    status: Literal["PASS", "FAIL"]


class LabReportAnalysisResponse(BaseModel):
    batch_id: str
    batch_decision: Literal["APPROVED_FOR_RELEASE", "NOT_APPROVED"]
    parameters: List[ParameterResult]
    failed_parameters: List[str]
    explanation: List[str]
    allow_qr_generation: bool
