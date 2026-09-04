import { Link } from "react-router-dom";

function Navbar() {
  return (
    <nav className="navbar">
      <Link to="/" className="logo">
        🍯 Hive2Home
      </Link>

      <div className="nav-links">
        <Link to="/">Home</Link>
        <Link to="/complaint">Report Issue</Link>
      </div>
    </nav>
  );
}

export default Navbar;