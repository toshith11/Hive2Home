import { Link } from "react-router-dom";

function Home() {
  return (
    <main>
      <section className="hero">
        <div className="hero-content">
          <p className="tagline">FROM HEALTHY HIVE TO TRUSTED HOME</p>

          <h1>
            Know the Journey
            <br />
            Behind Your Honey 🍯
          </h1>

          <p className="hero-text">
            Hive2Home connects beekeepers, laboratories, retailers and
            consumers through a trusted honey traceability system.
          </p>

          <div className="hero-buttons">
            <Link to="/verify/jar/H2H-JAR-001" className="primary-btn">
              Verify a Honey Jar
            </Link>

            <Link to="/verify/retailer/H2H-RET-001" className="secondary-btn">
              Verify Retailer
            </Link>
          </div>
        </div>
      </section>

      <section className="features">
        <h2>How Hive2Home Builds Trust</h2>

        <div className="feature-grid">
          <div className="feature-card">
            <div className="feature-icon">🐝</div>
            <h3>Hive Traceability</h3>
            <p>
              Track honey from its source apiary through harvesting and
              production.
            </p>
          </div>

          <div className="feature-card">
            <div className="feature-icon">🧪</div>
            <h3>Lab Verified</h3>
            <p>
              View verified laboratory quality information linked to the
              honey batch.
            </p>
          </div>

          <div className="feature-card">
            <div className="feature-icon">🔗</div>
            <h3>Blockchain Records</h3>
            <p>
              Traceability records help protect the integrity of the honey
              journey.
            </p>
          </div>

          <div className="feature-card">
            <div className="feature-icon">📱</div>
            <h3>QR Verification</h3>
            <p>
              Scan the jar or retailer QR to access verified product
              information.
            </p>
          </div>
        </div>
      </section>

      <section className="journey-preview">
        <h2>Honey Journey</h2>

        <div className="journey">
          <span>🐝 Hive</span>
          <span>→</span>
          <span>🍯 Harvest</span>
          <span>→</span>
          <span>🧪 Lab</span>
          <span>→</span>
          <span>🔗 Blockchain</span>
          <span>→</span>
          <span>🏪 Retailer</span>
          <span>→</span>
          <span>🏠 Home</span>
        </div>
      </section>
    </main>
  );
}

export default Home;