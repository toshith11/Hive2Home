import { Link } from "react-router-dom";

function NotFound() {
  return (
    <main className="page">
      <h1>404</h1>
      <h2>Page Not Found</h2>
      <Link to="/">Go back Home</Link>
    </main>
  );
}

export default NotFound;