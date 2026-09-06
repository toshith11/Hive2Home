import { useParams, Link } from "react-router-dom";

function Retailer() {
  const { retailerId } = useParams();

  const retailer = {
    id: retailerId || "H2H-RET-001",
    name: "ABC Organics",
    location: "Bengaluru, Karnataka",
    beekeeper: "Rajesh Kumar",
    brand: "Hive2Home",
    partnershipSince: "2025",
    status: "VERIFIED",
    products: [
      "Wildflower Honey",
      "Multifloral Honey",
      "Forest Honey",
    ],
  };

  return (
    <main className="retailer-page">

      {/* HEADER */}
      <section className="retailer-header">

        <div className="retailer-icon">
          🏪
        </div>

        <h1>
          {retailer.name}
        </h1>

        <p>
          Retailer / Supply Verification
        </p>

        <div className="retailer-verified-badge">
          ✓ VERIFIED RETAILER
        </div>

      </section>


      {/* RETAILER INFORMATION */}
      <section className="retailer-section">

        <h2>
          Retailer Information
        </h2>

        <div className="retailer-card">

          <div className="retailer-info-row">
            <span>
              Retailer ID
            </span>

            <strong>
              {retailer.id}
            </strong>
          </div>


          <div className="retailer-info-row">
            <span>
              Retailer Name
            </span>

            <strong>
              {retailer.name}
            </strong>
          </div>


          <div className="retailer-info-row">
            <span>
              Location
            </span>

            <strong>
              {retailer.location}
            </strong>
          </div>


          <div className="retailer-info-row">
            <span>
              Verification Status
            </span>

            <strong className="status-text">
              {retailer.status}
            </strong>
          </div>

        </div>

      </section>


      {/* SUPPLY RELATIONSHIP */}
      <section className="retailer-section">

        <h2>
          🔗 Verified Supply Relationship
        </h2>

        <p className="retailer-description">
          This retailer has a verified supply relationship
          with the beekeeper and honey supply chain recorded
          in Hive2Home.
        </p>

        <div className="retailer-card">

          <div className="retailer-info-row">
            <span>
              Beekeeper / Producer
            </span>

            <strong>
              {retailer.beekeeper}
            </strong>
          </div>


          <div className="retailer-info-row">
            <span>
              Brand
            </span>

            <strong>
              {retailer.brand}
            </strong>
          </div>


          <div className="retailer-info-row">
            <span>
              Partnership Since
            </span>

            <strong>
              {retailer.partnershipSince}
            </strong>
          </div>

        </div>

      </section>


      {/* PRODUCTS */}
      <section className="retailer-section">

        <h2>
          🍯 Products Supplied
        </h2>

        <div className="retailer-products">

          {retailer.products.map((product, index) => (

            <div
              className="retailer-product"
              key={index}
            >
              <span>
                🍯
              </span>

              {product}
            </div>

          ))}

        </div>

      </section>


      {/* SUPPLY CHAIN VERIFICATION */}
      <section className="retailer-section">

        <h2>
          🔐 Supply Chain Verification
        </h2>

        <div className="retailer-verification-card">

          <div>
            ✓ Retailer identity verified
          </div>

          <div>
            ✓ Beekeeper relationship verified
          </div>

          <div>
            ✓ Supply relationship recorded
          </div>

          <div>
            ✓ Traceability records available
          </div>

        </div>

      </section>


      {/* BACK BUTTON */}
      <div className="retailer-back">

        <Link
          to="/"
          className="retailer-back-btn"
        >
          ← Back to Hive2Home
        </Link>

      </div>

    </main>
  );
}

export default Retailer;