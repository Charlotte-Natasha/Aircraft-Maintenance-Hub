function StatusCards() {
  return (
    <section className="status-section">
      <div className="container">
        <h2>System Status</h2>
        
        <div className="status-cards">
          {/* Card 1: Total Aircraft */}
          <div className="card">
            <div className="card-icon">🛩️</div>
            <div className="card-value">0</div>
            <div className="card-label">Total Aircraft</div>
          </div>

          {/* Card 2: Serviceable */}
          <div className="card card-success">
            <div className="card-icon">✅</div>
            <div className="card-value">0</div>
            <div className="card-label">Serviceable</div>
          </div>

          {/* Card 3: In Maintenance */}
          <div className="card card-warning">
            <div className="card-icon">🔧</div>
            <div className="card-value">0</div>
            <div className="card-label">In Maintenance</div>
          </div>

          {/* Card 4: Pending Tasks */}
          <div className="card card-info">
            <div className="card-icon">📋</div>
            <div className="card-value">0</div>
            <div className="card-label">Pending Tasks</div>
          </div>

          {/* Card 5: Low Stock */}
          <div className="card card-danger">
            <div className="card-icon">📦</div>
            <div className="card-value">0</div>
            <div className="card-label">Low Stock Parts</div>
          </div>
        </div>
      </div>
    </section>
  );
}

export default StatusCards;