# Hive2Home — AI Engine (Member 5)

This service is the brain of Hive2Home. It does **not** touch the database or
blockchain directly — Member 4's backend calls these endpoints, gets a JSON
decision back, and persists it. This keeps the AI engine stateless and easy
to develop/test in isolation with simulated data while Members 1-4 build
against mock JSON.

## Four modules

| # | Module | File | What it does |
|---|--------|------|---------------|
| 1 | Hive Health Score | `app/hive_health.py` | Fuses temp/humidity/weight/sound → 0-100 health score + alerts |
| 2 | Production Prediction | `app/production_prediction.py` | Predicts honey yield (kg) from hive + seasonal + weather features |
| 3 | Location Recommendation | `app/location_recommendation.py` | Ranks candidate apiary locations for migration |
| 4 | Lab Report Analysis | `app/lab_report_analysis.py` | Extracts params from lab report → PASS/FAIL decision |

## Run it

```bash
pip install -r requirements.txt
uvicorn app.main:app --reload --port 8000
```

Docs auto-generate at `http://localhost:8000/docs` (FastAPI/Swagger) — send
Member 4 this link, it doubles as the API contract.

## API contract summary (for Member 4)

### `POST /hive-health/score`
Input: latest sensor readings (+ optionally a short window of history for
trend/anomaly detection).
Output: `health_score`, `status`, `flags[]`, `recommendation`.

### `POST /production/predict`
Input: hive/apiary features + season + weather.
Output: `predicted_yield_kg`, `confidence_range`, `key_drivers[]`.

### `POST /location/recommend`
Input: beekeeper's current location + list of candidate locations with their
flowering/weather/historical-yield data.
Output: ranked list of locations with a score and human-readable reason for each.

### `POST /lab-report/analyse`
Input: either raw extracted parameters (`{"moisture": 21.3, ...}`) **or** a
PDF/image file to run OCR/extraction on first.
Output:
```json
{
  "batch_decision": "NOT_APPROVED",
  "parameters": [
    {"name": "moisture", "value": 21.3, "unit": "%", "standard_max": 20.0, "status": "FAIL"},
    {"name": "hmf", "value": 12.4, "unit": "mg/kg", "standard_max": 80.0, "status": "PASS"}
  ],
  "failed_parameters": ["moisture"],
  "explanation": [
    "Moisture at 21.3% exceeds the 20% limit — usually caused by early harvesting (uncapped frames), high-humidity storage, or insufficient dehydration before extraction."
  ],
  "allow_qr_generation": false
}
```
Member 4 reads `allow_qr_generation` — `false` blocks the release/QR flow,
`true` lets it proceed automatically.

## Data note

Standard thresholds in `app/reference_standards.py` are typical honey-quality
benchmarks (FSSAI/Codex-style figures) used for prototype purposes. Before
using this for anything beyond a hackathon demo, verify the exact current
figures against the official FSSAI honey standard / the specific lab's
report format you're targeting.

## Dev workflow

Since Member 4's backend may not be ready yet, `app/utils/simulate_data.py`
generates fake historical hive/production data so modules 1-3 can be trained
and demoed standalone. Module 4 includes a synthetic sample lab report PDF
generator too, for demo purposes.
