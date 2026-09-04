import { useState } from "react";
import { useParams, Link } from "react-router-dom";

function Product() {
  const { jarId } = useParams();

  const [showLabReport, setShowLabReport] = useState(false);
  const [showBlockchain, setShowBlockchain] = useState(false);

  const product = {
    name: "Wildflower Honey",
    jarId: jarId || "H2H-JAR-001",
    batchId: "H2H-B2026-001",
    harvestDate: "03 September 2026",
    sourceApiary: "Green Valley Apiary",
    processingDate: "05 September 2026",
    labReportId: "LAB-2026-00128",
    labTestDate: "06 September 2026",
    retailer: "ABC Organics",
  };

  return (
    <main className="product-page">

      {/* PRODUCT HEADER */}
      <section className="product-header">

        <div>
          <p className="small-label">
            HIVE2HOME PRODUCT VERIFICATION
          </p>

          <h1>🍯 {product.name}</h1>

          <p>
            Verified honey product with a traceable journey
            from hive to consumer.
          </p>
        </div>

        <div className="verified-badge">
          ✓ VERIFIED PRODUCT
        </div>

      </section>


      {/* PRODUCT INFORMATION */}
      <section className="product-grid">

        <div className="info-card">

          <h2>🍯 Product Information</h2>

          <div className="info-row">
            <span>Jar ID</span>
            <strong>{product.jarId}</strong>
          </div>

          <div className="info-row">
            <span>Batch ID</span>
            <strong>{product.batchId}</strong>
          </div>

          <div className="info-row">
            <span>Honey Type</span>
            <strong>Wildflower Honey</strong>
          </div>

          <div className="info-row">
            <span>Source Apiary</span>
            <strong>{product.sourceApiary}</strong>
          </div>

          <div className="info-row">
            <span>Harvest Date</span>
            <strong>{product.harvestDate}</strong>
          </div>

          <div className="info-row">
            <span>Processing Date</span>
            <strong>{product.processingDate}</strong>
          </div>

        </div>


        {/* VERIFICATION STATUS */}
        <div className="info-card">

          <h2>🛡️ Verification Status</h2>

          <div className="status-success">
            ✓ This batch is approved for release.
          </div>

          <div className="info-row">
            <span>Batch Status</span>
            <strong className="passed-text">
              VERIFIED
            </strong>
          </div>

          <div className="info-row">
            <span>Laboratory Test</span>
            <strong className="passed-text">
              PASSED
            </strong>
          </div>

          <div className="info-row">
            <span>Traceability</span>
            <strong className="passed-text">
              VERIFIED
            </strong>
          </div>

        </div>

      </section>


      {/* HONEY JOURNEY */}
      <section className="journey-section">

        <h2>🌱 Honey Journey</h2>

        <p className="section-description">
          Follow the verified journey of this honey batch.
        </p>

        <div className="journey-timeline">

          <div className="timeline-item">
            <div className="timeline-icon">🐝</div>
            <h3>Hive</h3>
            <p>Honey produced in the source apiary.</p>
          </div>

          <div className="timeline-line"></div>

          <div className="timeline-item">
            <div className="timeline-icon">🍯</div>
            <h3>Harvest</h3>
            <p>{product.harvestDate}</p>
          </div>

          <div className="timeline-line"></div>

          <div className="timeline-item">
            <div className="timeline-icon">🧪</div>
            <h3>Laboratory</h3>
            <p>Quality test passed.</p>
          </div>

          <div className="timeline-line"></div>

          <div className="timeline-item">
            <div className="timeline-icon">🔐</div>
            <h3>Verified</h3>
            <p>Batch approved for release.</p>
          </div>

          <div className="timeline-line"></div>

          <div className="timeline-item">
            <div className="timeline-icon">🏪</div>
            <h3>Retailer</h3>
            <p>{product.retailer}</p>
          </div>

        </div>

      </section>


      {/* LAB + BLOCKCHAIN */}
      <section className="detail-section">

        {/* LAB REPORT */}
        <div className="detail-card">

          <h2>🧪 Laboratory Verification</h2>

          <div className="status-success">
            ✓ QUALITY TEST PASSED
          </div>

          <div className="info-row">
            <span>Report ID</span>
            <strong>{product.labReportId}</strong>
          </div>

          <div className="info-row">
            <span>Test Date</span>
            <strong>{product.labTestDate}</strong>
          </div>

          <div className="info-row">
            <span>Quality Status</span>
            <strong className="passed-text">
              PASSED
            </strong>
          </div>

          <button
            className="outline-btn"
            onClick={() => setShowLabReport(true)}
          >
            📄 View Lab Report
          </button>

        </div>


        {/* BLOCKCHAIN */}
        <div className="detail-card">

          <h2>🔗 Blockchain Traceability</h2>

          <p className="blockchain-status">
            ✓ Batch traceability record verified
          </p>

          <div className="info-row">
            <span>Batch Record</span>
            <strong>{product.batchId}</strong>
          </div>

          <div className="info-row">
            <span>Integrity</span>
            <strong className="passed-text">
              VERIFIED
            </strong>
          </div>

          <div className="info-row">
            <span>Record Status</span>
            <strong className="passed-text">
              CONFIRMED
            </strong>
          </div>

          <button
            className="outline-btn"
            onClick={() => setShowBlockchain(true)}
          >
            🔗 View Blockchain Record
          </button>

        </div>

      </section>


      {/* RETAILER */}
      <section className="retailer-card">

        <div>
          <h2>🏪 Verified Retailer</h2>

          <p>
            This product is associated with:
            <strong> {product.retailer}</strong>
          </p>
        </div>

        <span className="verified-small">
          ✓ VERIFIED
        </span>

      </section>


      {/* COMPLAINT */}
      <section className="complaint-section">

        <h2>⚠️ Found a problem?</h2>

        <p>
          If you have a quality, packaging or other concern,
          you can submit a complaint for traceability investigation.
        </p>

        <Link
          to="/complaint"
          className="primary-btn"
        >
          Report a Problem
        </Link>

      </section>


      {/* LAB REPORT MODAL */}
      {showLabReport && (
        <div
          className="modal-overlay"
          onClick={() => setShowLabReport(false)}
        >

          <div
            className="modal-card"
            onClick={(e) => e.stopPropagation()}
          >

            <button
              className="modal-close"
              onClick={() => setShowLabReport(false)}
            >
              ✕
            </button>

            <h2>🧪 Laboratory Report</h2>

            <div className="demo-warning">
              Prototype / Demo Laboratory Report
            </div>

            <div className="modal-info">

              <div>
                <span>Report ID</span>
                <strong>{product.labReportId}</strong>
              </div>

              <div>
                <span>Batch ID</span>
                <strong>{product.batchId}</strong>
              </div>

              <div>
                <span>Test Date</span>
                <strong>{product.labTestDate}</strong>
              </div>

              <div>
                <span>Quality Status</span>
                <strong className="passed-text">
                  PASSED
                </strong>
              </div>

            </div>

            <h3>Quality Parameters</h3>

            <div className="test-result passed">
              ✓ Moisture — Within configured limit
            </div>

            <div className="test-result passed">
              ✓ Sugar profile — Passed
            </div>

            <div className="test-result passed">
              ✓ HMF — Passed
            </div>

            <div className="test-result passed">
              ✓ Quality evaluation — Passed
            </div>

            <p className="modal-note">
              This simulated report is provided only for the
              Hive2Home prototype and is not an official
              laboratory certificate.
            </p>

          </div>

        </div>
      )}


      {/* BLOCKCHAIN MODAL */}
      {showBlockchain && (
        <div
          className="modal-overlay"
          onClick={() => setShowBlockchain(false)}
        >

          <div
            className="modal-card"
            onClick={(e) => e.stopPropagation()}
          >

            <button
              className="modal-close"
              onClick={() => setShowBlockchain(false)}
            >
              ✕
            </button>

            <h2>🔗 Blockchain Traceability Record</h2>

            <div className="demo-warning">
              Prototype Blockchain Record
            </div>

            <div className="modal-info">

              <div>
                <span>Batch ID</span>
                <strong>{product.batchId}</strong>
              </div>

              <div>
                <span>Record Status</span>
                <strong className="passed-text">
                  VERIFIED
                </strong>
              </div>

              <div>
                <span>Integrity</span>
                <strong className="passed-text">
                  VERIFIED
                </strong>
              </div>

              <div>
                <span>Record ID</span>
                <strong>H2H-TX-2026-001</strong>
              </div>

            </div>

            <h3>Recorded Journey</h3>

            <div className="blockchain-event">
              ✓ Hive Record
            </div>

            <div className="blockchain-event">
              ✓ Harvest Record
            </div>

            <div className="blockchain-event">
              ✓ Laboratory Record
            </div>

            <div className="blockchain-event">
              ✓ Verification Record
            </div>

            <div className="blockchain-event">
              ✓ Retailer Supply Record
            </div>

            <p className="modal-note">
              Blockchain integration will be connected to the
              backend blockchain service in the next stage.
            </p>

          </div>

        </div>
      )}

    </main>
  );
}

export default Product;