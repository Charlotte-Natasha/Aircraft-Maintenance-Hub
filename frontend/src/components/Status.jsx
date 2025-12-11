import { useEffect, useState } from "react";

function StatusCards() {
  const [data, setData] = useState({
    total: 0,
    serviceable: 0,
    maintenance: 0,
    pending: 0,
    lowStock: 0
  });

  useEffect(() => {
    fetch("http://localhost:8000/status") // your API route
      .then((res) => res.json())
      .then((resData) => setData(resData))
      .catch((err) => console.error(err));
  }, []);

  return (
    <section className="status-section">
      <div className="container">
        <h2>System Status</h2>
        <div className="status-cards">
          <div className="card card-total">
            <div className="card-icon">🛩️</div>
            <div className="card-value">{data.total}</div>
            <div className="card-label">Total Aircraft</div>
          </div>
          <div className="card card-success">
            <div className="card-icon">✅</div>
            <div className="card-value">{data.serviceable}</div>
            <div className="card-label">Serviceable</div>
          </div>
          <div className="card card-maintenance">
            <div className="card-icon">🔧</div>
            <div className="card-value">{data.maintenance}</div>
            <div className="card-label">In Maintenance</div>
          </div>
          <div className="card card-pending">
            <div className="card-icon">📋</div>
            <div className="card-value">{data.pending}</div>
            <div className="card-label">Pending Tasks</div>
          </div>
          <div className="card card-lowstock">
            <div className="card-icon">📦</div>
            <div className="card-value">{data.lowStock}</div>
            <div className="card-label">Low Stock Parts</div>
          </div>
        </div>
      </div>
    </section>
  );
}

export default StatusCards;
