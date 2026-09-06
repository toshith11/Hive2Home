import { useState } from "react";
import { useParams, Link } from "react-router-dom";

function Product() {
  const { jarId } = useParams();

  const [showLabReport, setShowLabReport] = useState(false);
  const [showBlockchain, setShowBlockchain] = useState(false);

  // Prototype product data
  // This will later be replaced by backend API data.
  const product = {
    name: "Wildflower Honey",
    honeyType: "Wildflower Honey",
    jarId: jarId || "H2H-JAR-001",
    batchId: "H2H-B2026-001",
    harvestDate: "03 September 2026",
    sourceApiary: "Green Valley Apiary",
    beekeeper: "Rajesh Kumar",
    processingDate: "05 September 2026",
    labReportId: "LAB-2026-00128",
    labTestDate: "06 September 2026",
    retailer: "ABC Organics",
  };

  return (
    <main className="product-page">

      {/* =========================================
          PRODUCT HEADER
          ========================================= */}

      <section className="product-header">

        <div className="product-icon">
          🍯
        </div>

        <h1>{product.name}</h1>

        <p>
          Hive2Home Product Verification
        </p>

        <div className="verified-badge">
          ✓ VERIFIED HONEY
        </div>

      </section>


      {/* =========================================
          PRODUCT INFORMATION
          ========================================= */}

      <section className="product-section">

        <h2>🍯 Product Information</h2>

        <div className="info-card">

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
            <strong>{product.honeyType}</strong>
          </div>

          <div className="info-row">
            <span>Source Apiary</span>
            <strong>{product.sourceApiary}</strong>
          </div>

          <div className="info-row">
            <span>Beekeeper / Producer</span>
            <strong>{product.beekeeper}</strong>
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

      </section>


      {/* =========================================
          VERIFICATION STATUS
          ========================================= */}

      <section className="product-section">

        <h2>✅ Verification Status</h2>

        <div className="verification-status-card">

          <div className="status-item">
            <span>Batch Status</span>
            <strong className="status-success">
              VERIFIED
            </strong>
          </div>

          <div className="status-item">
            <span>Laboratory Test</span>
            <strong className="status-success">
              PASSED
            </strong>
          </div>

          <div className="status-item">
            <span>Release Status</span>
            <strong className="status-success">
              APPROVED FOR RELEASE
            </strong>
          </div>

          <div className="status-item">
            <span>Traceability</span>
            <strong className="status-success">
              VERIFIED
            </strong>
          </div>

        </div>

      </section>


      {/* =========================================
          HONEY JOURNEY
          ========================================= */}

      <section className="journey-section">

        <h2>🌱 Honey Journey</h2>

        <p className="section-description">
          Follow the verified journey of this honey batch
          from hive to retailer.
        </p>

        <div className="journey-timeline">

          {/* HIVE */}

          <div className="timeline-item">

            <div className="timeline-icon">
              🐝
            </div>

            <h3>Hive</h3>

            <p>
              Honey produced at {product.sourceApiary}.
            </p>

          </div>


          <div className="timeline-line"></div>


          {/* HARVEST */}

          <div className="timeline-item">

            <div className="timeline-icon">
              🍯
            </div>

            <h3>Harvest</h3>

            <p>
              Harvested on {product.harvestDate}.
            </p>

          </div>


          <div className="timeline-line"></div>


          {/* PROCESSING */}

          <div className="timeline-item">

            <div className="timeline-icon">
              🏭
            </div>

            <h3>Processing</h3>

            <p>
              Processed on {product.processingDate}.
            </p>

          </div>


          <div className="timeline-line"></div>


          {/* LABORATORY */}

          <div className="timeline-item">

            <div className="timeline-icon">
              🧪
            </div>

            <h3>Laboratory</h3>

            <p>
              Quality test completed and passed.
            </p>

          </div>


          <div className="timeline-line"></div>


          {/* BLOCKCHAIN */}

          <div className="timeline-item">

            <div className="timeline-icon">
              🔐
            </div>

            <h3>Blockchain Verified</h3>

            <p>
              Batch traceability record confirmed.
            </p>

          </div>


          <div className="timeline-line"></div>


          {/* RETAILER */}

          <div className="timeline-item">

            <div className="timeline-icon">
              🏪
            </div>

            <h3>Retailer</h3>

            <p>
              Supplied to {product.retailer}.
            </p>

          </div>

        </div>

      </section>


      {/* =========================================
          LAB + BLOCKCHAIN
          ========================================= */}

      <section className="verification-details">

        {/* LAB REPORT */}

        <div className="detail-card">

          <div className="detail-icon">
            🧪
          </div>

          <h3>
            Laboratory Verification
          </h3>

          <p>
            Official laboratory testing has been completed
            for this honey batch.
          </p>

          <div className="detail-info">

            <div>
              <span>Report ID</span>
              <strong>
                {product.labReportId}
              </strong>
            </div>

            <div>
              <span>Test Date</span>
              <strong>
                {product.labTestDate}
              </strong>
            </div>

            <div>
              <span>Result</span>
              <strong className="status-success">
                PASSED
              </strong>
            </div>

          </div>

          <button
            className="detail-btn"
            onClick={() => setShowLabReport(true)}
          >
            View Lab Report
          </button>

        </div>


        {/* BLOCKCHAIN */}

        <div className="detail-card">

          <div className="detail-icon">
            🔗
          </div>

          <h3>
            Blockchain Traceability
          </h3>

          <p>
            The verified batch traceability record is linked
            to the Hive2Home blockchain system.
          </p>

          <div className="detail-info">

            <div>
              <span>Batch</span>
              <strong>
                {product.batchId}
              </strong>
            </div>

            <div>
              <span>Record Status</span>
              <strong className="status-success">
                VERIFIED
              </strong>
            </div>

            <div>
              <span>Traceability</span>
              <strong>
                CONFIRMED
              </strong>
            </div>

          </div>

          <button
            className="detail-btn"
            onClick={() => setShowBlockchain(true)}
          >
            View Blockchain Record
          </button>

        </div>

      </section>


      {/* =========================================
          RETAILER VERIFICATION
          ========================================= */}

      <section className="retailer-product-section">

        <h2>🏪 Retailer Verification</h2>

        <div className="retailer-product-card">

          <div>

            <h3>
              {product.retailer}
            </h3>

            <p>
              Verified retailer associated with this
              honey supply chain.
            </p>

          </div>

          <div className="retailer-status">
            ✓ VERIFIED
          </div>

        </div>

      </section>


      {/* =========================================
          REPORT ISSUE
          ========================================= */}

      <section className="complaint-section">

        <h2>
          🧾 Found an Issue?
        </h2>

        <p>
          If you have concerns about this honey product,
          you can submit a traceability complaint for
          investigation.
        </p>

        <Link
          to="/complaint"
          className="complaint-btn"
        >
          Report an Issue
        </Link>

      </section>


      {/* =========================================
          LAB REPORT MODAL
          ========================================= */}

      {showLabReport && (

        <div
          className="modal-overlay"
          onClick={() => setShowLabReport(false)}
        >

          <div
            className="modal-card"
            onClick={(event) => event.stopPropagation()}
          >

            <button
              className="modal-close"
              onClick={() => setShowLabReport(false)}
            >
              ✕
            </button>

            <h2>
              🧪 Laboratory Report
            </h2>

            <div className="modal-status">
              ✓ QUALITY TEST PASSED
            </div>

            <div className="modal-info">

              <div>
                <span>Report ID</span>
                <strong>
                  {product.labReportId}
                </strong>
              </div>

              <div>
                <span>Batch ID</span>
                <strong>
                  {product.batchId}
                </strong>
              </div>

              <div>
                <span>Test Date</span>
                <strong>
                  {product.labTestDate}
                </strong>
              </div>

              <div>
                <span>Result</span>
                <strong>
                  PASSED
                </strong>
              </div>

            </div>

            <p className="prototype-note">
              Prototype demonstration: laboratory report
              data shown here is simulated. Official
              laboratory testing remains the source of
              official quality verification.
            </p>

          </div>

        </div>

      )}


      {/* =========================================
          BLOCKCHAIN MODAL
          ========================================= */}

      {showBlockchain && (

        <div
          className="modal-overlay"
          onClick={() => setShowBlockchain(false)}
        >

          <div
            className="modal-card"
            onClick={(event) => event.stopPropagation()}
          >

            <button
              className="modal-close"
              onClick={() => setShowBlockchain(false)}
            >
              ✕
            </button>

            <h2>
              🔗 Blockchain Traceability
            </h2>

            <div className="modal-status">
              ✓ TRACEABILITY VERIFIED
            </div>

            <div className="modal-info">

              <div>
                <span>Batch ID</span>
                <strong>
                  {product.batchId}
                </strong>
              </div>

              <div>
                <span>Jar ID</span>
                <strong>
                  {product.jarId}
                </strong>
              </div>

              <div>
                <span>Blockchain Status</span>
                <strong>
                  VERIFIED
                </strong>
              </div>

              <div>
                <span>Record</span>
                <strong>
                  IMMUTABLE TRACEABILITY RECORD
                </strong>
              </div>

            </div>

            <p className="prototype-note">
              Prototype demonstration: blockchain record
              shown here is simulated. In the final system,
              this information will be retrieved from the
              Hive2Home blockchain backend.
            </p>

          </div>

        </div>

      )}

    </main>
  );
}

export default Product;