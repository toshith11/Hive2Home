import { useState } from "react";

function Complaint() {
  const [submitted, setSubmitted] = useState(false);
  const [complaintId, setComplaintId] = useState("");

  const handleSubmit = (e) => {
    e.preventDefault();

    const id = "H2H-CMP-" + Math.floor(1000 + Math.random() * 9000);

    setComplaintId(id);
    setSubmitted(true);
  };

  if (submitted) {
    return (
      <main className="complaint-page">
        <section className="complaint-success">
          <div className="success-icon">✓</div>

          <h1>Complaint Submitted</h1>

          <p>
            Your complaint has been successfully recorded for
            traceability investigation.
          </p>

          <div className="complaint-id">
            <span>Complaint ID</span>
            <strong>{complaintId}</strong>
          </div>

          <p className="success-note">
            Please keep this Complaint ID for future reference.
          </p>

          <a href="/" className="primary-btn">
            Back to Home
          </a>
        </section>
      </main>
    );
  }

  return (
    <main className="complaint-page">

      <section className="complaint-header">
        <p className="small-label">HIVE2HOME SUPPORT</p>

        <h1>Report a Product Issue ⚠️</h1>

        <p>
          Help us investigate quality, packaging or other concerns
          using the product's traceability information.
        </p>
      </section>

      <section className="complaint-container">

        <form className="complaint-form" onSubmit={handleSubmit}>

          <h2>Complaint Details</h2>

          <label>Jar ID</label>
          <input
            type="text"
            placeholder="Example: H2H-JAR-001"
            required
          />

          <label>Batch ID</label>
          <input
            type="text"
            placeholder="Example: H2H-B2026-001"
            required
          />

          <label>Purchase Location</label>
          <input
            type="text"
            placeholder="Enter retailer or location"
            required
          />

          <label>Purchase Date</label>
          <input
            type="date"
            required
          />

          <label>Issue Type</label>
          <select required>
            <option value="">Select issue type</option>
            <option value="quality">Quality</option>
            <option value="health">Health Concern</option>
            <option value="packaging">Packaging</option>
            <option value="other">Other</option>
          </select>

          <label>Description</label>

          <textarea
            placeholder="Describe the issue you experienced..."
            required
          ></textarea>

          <label>Evidence</label>

          <input
            type="file"
            accept="image/*,.pdf"
          />

          <button type="submit" className="submit-btn">
            Submit Complaint
          </button>

        </form>

        <aside className="investigation-info">

          <h2>🔍 What happens next?</h2>

          <div className="investigation-step">
            <span>1</span>
            <p>Complaint is recorded with the product information.</p>
          </div>

          <div className="investigation-step">
            <span>2</span>
            <p>
              Traceability records can be checked against the batch.
            </p>
          </div>

          <div className="investigation-step">
            <span>3</span>
            <p>
              Laboratory and production information can be reviewed.
            </p>
          </div>

          <div className="investigation-step">
            <span>4</span>
            <p>
              The system can generate a neutral investigation summary.
            </p>
          </div>

          <div className="important-note">
            <strong>Important:</strong>
            <p>
              Hive2Home does not automatically declare a beekeeper or
              retailer guilty. The investigation is based on available
              traceability evidence.
            </p>
          </div>

        </aside>

      </section>

    </main>
  );
}

export default Complaint;