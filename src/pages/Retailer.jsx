import { useParams } from "react-router-dom";

function Retailer() {
  const { retailerId } = useParams();

  return (
    <main className="retailer-page">

      <section className="retailer-hero">
        <p className="small-label">HIVE2HOME RETAILER VERIFICATION</p>

        <h1>🏪 Retailer Verification</h1>

        <p>
          Verify whether this retailer is part of the trusted Hive2Home
          honey supply network.
        </p>

        <div className="verified-badge">
          ✓ VERIFIED RETAILER
        </div>
      </section>

      <section className="retailer-content">

        <div className="retailer-info-card">
          <h2>Retailer Information</h2>

          <div className="info-row">
            <span>Retailer ID</span>
            <strong>{retailerId}</strong>
          </div>

          <div className="info-row">
            <span>Retailer Name</span>
            <strong>ABC Organics</strong>
          </div>

          <div className="info-row">
            <span>Verification Status</span>
            <strong className="passed-text">✓ Verified</strong>
          </div>

          <div className="info-row">
            <span>Associated Network</span>
            <strong>Hive2Home</strong>
          </div>

          <div className="info-row">
            <span>Verified Since</span>
            <strong>September 2026</strong>
          </div>
        </div>

        <div className="retailer-info-card">
          <h2>🔗 Supply Verification</h2>

          <div className="supply-status">
            ✓ Verified beekeeper relationship
          </div>

          <div className="supply-status">
            ✓ Verified honey supply records
          </div>

          <div className="supply-status">
            ✓ Traceability records available
          </div>

          <p>
            Honey products supplied through this retailer are linked with
            Hive2Home traceability records.
          </p>
        </div>

      </section>

      <section className="verified-products">

        <h2>🍯 Verified Honey Products</h2>

        <div className="product-mini-card">
          <div>
            <h3>Wildflower Honey</h3>
            <p>Batch: H2H-B2026-001</p>
          </div>

          <span className="mini-verified">
            ✓ Verified
          </span>
        </div>

        <div className="product-mini-card">
          <div>
            <h3>Forest Honey</h3>
            <p>Batch: H2H-B2026-002</p>
          </div>

          <span className="mini-verified">
            ✓ Verified
          </span>
        </div>

      </section>

      <section className="retailer-note">

        <h2>Why verify the retailer?</h2>

        <p>
          Hive2Home helps consumers confirm that honey is being supplied
          through a verified retailer relationship, improving transparency
          across the supply chain.
        </p>

      </section>

    </main>
  );
}

export default Retailer;