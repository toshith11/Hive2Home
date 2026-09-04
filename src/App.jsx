import { BrowserRouter, Routes, Route } from "react-router-dom";
import Navbar from "./components/Navbar";
import Footer from "./components/Footer";
import Home from "./pages/Home";
import Product from "./pages/Product";
import Retailer from "./pages/Retailer";
import Complaint from "./pages/Complaint";
import NotFound from "./pages/NotFound";
import "./App.css";

function App() {
  return (
    <BrowserRouter>
      <Navbar />

      <Routes>
        <Route path="/" element={<Home />} />
        <Route path="/verify/jar/:jarId" element={<Product />} />
        <Route path="/verify/retailer/:retailerId" element={<Retailer />} />
        <Route path="/complaint" element={<Complaint />} />
        <Route path="*" element={<NotFound />} />
      </Routes>

      <Footer />
    </BrowserRouter>
  );
}

export default App;