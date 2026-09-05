"""
Module 4: Lab Report Analysis

Workflow: Lab Report Upload -> Extract Parameters -> Analyse Results -> Quality Decision

Case 1 (FAIL): batch marked NOT_APPROVED, QR generation blocked, AI explains
               the likely cause of each failed parameter.
Case 2 (PASS): batch marked APPROVED_FOR_RELEASE, allow_qr_generation=True
               so Member 4's backend can proceed with release + QR generation.

Two entry points:
  - analyse_parameters(): parameters already extracted (e.g. beekeeper typed
    them in, or another system pre-parsed them) -> straight to analysis.
  - extract_parameters_from_pdf(): pulls a parameter table out of an actual
    lab report PDF using pdfplumber, for the "upload the real PDF" flow.
"""
import re
from typing import Dict, List
import pdfplumber

from app.schemas import LabParameterInput, LabReportAnalysisResponse, ParameterResult
from app.reference_standards import LAB_QUALITY_STANDARDS

# Common aliases seen on real lab reports -> our internal parameter names
_PARAM_ALIASES = {
    "moisture content": "moisture",
    "moisture": "moisture",
    "hmf": "hmf",
    "hydroxymethylfurfural": "hmf",
    "reducing sugar": "reducing_sugars",
    "reducing sugars": "reducing_sugars",
    "sucrose": "sucrose",
    "ash content": "ash",
    "ash": "ash",
    "diastase activity": "diastase_activity",
    "diastase": "diastase_activity",
    "fructose/glucose ratio": "fructose_glucose_ratio",
    "f/g ratio": "fructose_glucose_ratio",
    "pesticide residue": "pesticide_residue",
    "antibiotic residue": "antibiotic_residue",
}


def extract_parameters_from_pdf(file_path: str) -> Dict[str, float]:
    """
    Extracts a {parameter_name: value} dict from a lab report PDF.

    Strategy: pull all tables via pdfplumber, then also regex-scan raw text
    as a fallback for reports that aren't in clean table format. This is a
    best-effort extractor for a prototype — real lab reports vary a lot in
    layout, so pair this with a manual-correction UI step in the app rather
    than trusting extraction blindly.
    """
    extracted: Dict[str, float] = {}
    number_pattern = re.compile(r"(-?\d+\.?\d*)")

    with pdfplumber.open(file_path) as pdf:
        full_text = ""
        for page in pdf.pages:
            full_text += (page.extract_text() or "") + "\n"
            for table in page.extract_tables() or []:
                for row in table:
                    if not row or len(row) < 2:
                        continue
                    label = (row[0] or "").strip().lower()
                    value_cell = (row[1] or "").strip()
                    key = _PARAM_ALIASES.get(label)
                    if key:
                        match = number_pattern.search(value_cell)
                        if match:
                            extracted[key] = float(match.group(1))

        # fallback: regex over raw text for anything the table parser missed
        for alias, key in _PARAM_ALIASES.items():
            if key in extracted:
                continue
            line_match = re.search(rf"{re.escape(alias)}\s*[:\-]?\s*(-?\d+\.?\d*)", full_text, re.IGNORECASE)
            if line_match:
                extracted[key] = float(line_match.group(1))

    return extracted


def _check_parameter(name: str, value: float) -> ParameterResult:
    std = LAB_QUALITY_STANDARDS.get(name)
    if std is None:
        # unknown parameter: record it but don't fail the batch on something
        # we don't have a documented standard for
        return ParameterResult(
            name=name, value=value, unit="", limit_description="No reference standard configured", status="PASS"
        )

    unit = std.get("unit", "")
    passed = True
    limit_parts = []
    if "min" in std:
        limit_parts.append(f"min {std['min']}{unit}")
        if value < std["min"]:
            passed = False
    if "max" in std:
        limit_parts.append(f"max {std['max']}{unit}")
        if value > std["max"]:
            passed = False

    return ParameterResult(
        name=name,
        value=value,
        unit=unit,
        limit_description=" / ".join(limit_parts),
        status="PASS" if passed else "FAIL",
    )


def analyse_parameters(req: LabParameterInput) -> LabReportAnalysisResponse:
    results: List[ParameterResult] = []
    for name, value in req.parameters.items():
        results.append(_check_parameter(name, float(value)))

    failed = [r for r in results if r.status == "FAIL"]

    if failed:
        explanations = [
            LAB_QUALITY_STANDARDS.get(r.name, {}).get(
                "fail_reason", f"{r.name} is outside the expected range."
            )
            for r in failed
        ]
        return LabReportAnalysisResponse(
            batch_id=req.batch_id,
            batch_decision="NOT_APPROVED",
            parameters=results,
            failed_parameters=[r.name for r in failed],
            explanation=explanations,
            allow_qr_generation=False,
        )

    return LabReportAnalysisResponse(
        batch_id=req.batch_id,
        batch_decision="APPROVED_FOR_RELEASE",
        parameters=results,
        failed_parameters=[],
        explanation=["All tested parameters are within accepted limits. Batch is approved for release."],
        allow_qr_generation=True,
    )
