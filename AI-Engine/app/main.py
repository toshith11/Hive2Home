"""
Hive2Home AI Engine — FastAPI entrypoint (Member 5).

Run with:
    uvicorn app.main:app --reload --port 8000

Then open http://localhost:8000/docs for interactive API docs — send this
link to Member 4 as the live API contract.
"""
import tempfile
import shutil

from fastapi import FastAPI, UploadFile, File, Form, HTTPException

from app.schemas import (
    HiveHealthRequest, HiveHealthResponse,
    ProductionPredictRequest, ProductionPredictResponse,
    LocationRecommendRequest, LocationRecommendResponse,
    LabParameterInput, LabReportAnalysisResponse,
)
from app.hive_health import compute_hive_health
from app.production_prediction import predict_production
from app.location_recommendation import recommend_locations
from app.lab_report_analysis import analyse_parameters, extract_parameters_from_pdf

app = FastAPI(
    title="Hive2Home AI Engine",
    description="Member 5 — Hive Health, Production Prediction, Location Recommendation, Lab Report Analysis",
    version="0.1.0",
)


@app.get("/")
def root():
    return {"status": "ok", "service": "hive2home-ai-engine"}


# ---------------------------------------------------------------------
# 1. Hive Health
# ---------------------------------------------------------------------
@app.post("/hive-health/score", response_model=HiveHealthResponse)
def hive_health_score(req: HiveHealthRequest):
    try:
        return compute_hive_health(req.hive_id, req.readings)
    except ValueError as e:
        raise HTTPException(status_code=400, detail=str(e))


# ---------------------------------------------------------------------
# 2. Production Prediction
# ---------------------------------------------------------------------
@app.post("/production/predict", response_model=ProductionPredictResponse)
def production_predict(req: ProductionPredictRequest):
    return predict_production(req)


# ---------------------------------------------------------------------
# 3. Location Recommendation
# ---------------------------------------------------------------------
@app.post("/location/recommend", response_model=LocationRecommendResponse)
def location_recommend(req: LocationRecommendRequest):
    if not req.candidates:
        raise HTTPException(status_code=400, detail="candidates list cannot be empty")
    return recommend_locations(req)


# ---------------------------------------------------------------------
# 4. Lab Report Analysis
# ---------------------------------------------------------------------
@app.post("/lab-report/analyse", response_model=LabReportAnalysisResponse)
def lab_report_analyse(req: LabParameterInput):
    """Use this when parameters are already extracted (e.g. beekeeper typed
    them in via the app, or another step already parsed the PDF)."""
    return analyse_parameters(req)


@app.post("/lab-report/analyse-pdf", response_model=LabReportAnalysisResponse)
async def lab_report_analyse_pdf(batch_id: str = Form(...), file: UploadFile = File(...)):
    """Use this for the 'upload the real PDF' flow: extracts parameters from
    the uploaded lab report, then runs the same PASS/FAIL analysis."""
    if not file.filename.lower().endswith(".pdf"):
        raise HTTPException(status_code=400, detail="Only PDF lab reports are supported in this prototype.")

    with tempfile.NamedTemporaryFile(delete=False, suffix=".pdf") as tmp:
        shutil.copyfileobj(file.file, tmp)
        tmp_path = tmp.name

    try:
        params = extract_parameters_from_pdf(tmp_path)
    except Exception as e:
        raise HTTPException(status_code=422, detail=f"Could not parse PDF: {e}")

    if not params:
        raise HTTPException(
            status_code=422,
            detail="No recognised lab parameters found in the PDF. "
                   "The beekeeper may need to enter values manually via /lab-report/analyse.",
        )

    return analyse_parameters(LabParameterInput(batch_id=batch_id, parameters=params))
