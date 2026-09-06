import { Link } from "react-router-dom";

function Home() {
  return (
    <main className="home-page">

      {/* =====================================================
          HERO
          ===================================================== */}
      <section className="hero">

        {/* LEFT CONTENT */}
        <div className="hero-content">

          <div className="tagline">
            FROM HEALTHY HIVE TO TRUSTED HOME
          </div>

          <h1>
            Know the journey behind your honey
            <br />
          </h1>

          <p className="hero-text">
            Hive2Home connects beekeepers, laboratories, retailers
            and consumers through smart hive monitoring, AI-assisted
            analysis, blockchain traceability and QR-powered verification.
          </p>

        </div>

      </section>


      {/* =====================================================
          CONSUMER VERIFICATION
          ===================================================== */}
      <section className="qr-section">

        <div className="section-heading">

          <span className="section-tag">
            🔍 CONSUMER VERIFICATION
          </span>

          <h2>
            Scan. Verify. Trust.
          </h2>

          <p>
            Use your phone camera to scan a Hive2Home QR code
            and explore the verified honey journey.
          </p>

        </div>


        <div className="qr-options">

          {/* HONEY */}

          <div className="qr-card">

            <div className="qr-card-icon">
              🍯
            </div>

            <h3>
              Verify Honey
            </h3>

            <p>
              Scan the QR code printed on your honey jar to
              verify the product, batch, beekeeper, laboratory
              verification and honey journey.
            </p>

            <Link
              to="/verify/jar/H2H-JAR-001"
              className="qr-action-btn"
            >
              🍯 Verify Honey
            </Link>

          </div>


          {/* RETAILER */}

          <div className="qr-card">

            <div className="qr-card-icon">
              🏪
            </div>

            <h3>
              Verify Retailer
            </h3>

            <p>
              Scan the QR displayed at a retailer or shelf
              to verify its relationship with the honey
              supply chain.
            </p>

            <Link
              to="/verify/retailer/H2H-RET-001"
              className="qr-action-btn"
            >
              🏪 Verify Retailer
            </Link>

          </div>

        </div>

      </section>


      {/* =====================================================
          HOW IT WORKS
          ===================================================== */}

      <section className="how-section">

        <div className="section-heading">

          <span className="section-tag">
            🐝 HOW HIVE2HOME BUILDS TRUST
          </span>

          <h2>
            From Hive to Home
          </h2>

        </div>


        <div className="how-steps">

          <div className="how-step">

            <div className="how-icon">
              🐝
            </div>

            <h3>
              Smart Hive
            </h3>

            <p>
              Hive conditions are monitored using IoT sensors.
            </p>

          </div>


          <div className="how-step">

            <div className="how-icon">
              🍯
            </div>

            <h3>
              Production
            </h3>

            <p>
              Honey production and batch information are recorded.
            </p>

          </div>


          <div className="how-step">

            <div className="how-icon">
              🧪
            </div>

            <h3>
              Laboratory
            </h3>

            <p>
              Honey quality is verified through laboratory testing.
            </p>

          </div>


          <div className="how-step">

            <div className="how-icon">
              🔐
            </div>

            <h3>
              Blockchain
            </h3>

            <p>
              Traceability records are securely connected.
            </p>

          </div>


          <div className="how-step">

            <div className="how-icon">
              🏠
            </div>

            <h3>
              Trusted Home
            </h3>

            <p>
              Consumers can verify the journey before purchase.
            </p>

          </div>

        </div>

      </section>


      {/* =====================================================
          FINAL CTA
          ===================================================== */}

      <section className="home-cta">

        <h2>
          Know where your honey comes from.
        </h2>

        <p>
          Scan the Hive2Home QR and discover its verified journey.
        </p>

      </section>

    </main>
  );
}

export default Home;