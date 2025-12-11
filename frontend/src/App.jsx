import { useState, useEffect } from 'react';
import { fetchStatus } from './services/api';

function App() {
  // State to store status data
  const [status, setStatus] = useState(null);
  const [loading, setLoading] = useState(true);
  const [error, setError] = useState(null);

  // Fetch status when component mounts
  useEffect(() => {
    const getStatus = async () => {
      try {
        setLoading(true);
        const data = await fetchStatus();
        setStatus(data);
        setError(null);
      } catch (err) {
        setError(err.message);
      } finally {
        setLoading(false);
      }
    };

    getStatus();
  }, []); // Empty dependency array = run once on mount

  return (
    <div style={{ padding: '20px', fontFamily: 'Arial, sans-serif' }}>
      <h1>✈️ MaintenanceHub</h1>
      <h2>System Status</h2>

      {/* Loading State */}
      {loading && <p>Loading...</p>}

      {/* Error State */}
      {error && (
        <div style={{ color: 'red', padding: '10px', border: '1px solid red' }}>
          Error: {error}
        </div>
      )}

      {/* Success State */}
      {status && (
        <div>
          <p>Status: <strong>{status.status}</strong></p>
          <p>Database: <strong>{status.database}</strong></p>
          
          <h3>Metrics:</h3>
          <ul>
            <li>Total Aircraft: {status.metrics?.total_aircraft}</li>
            <li>Serviceable: {status.metrics?.serviceable_aircraft}</li>
            <li>In Maintenance: {status.metrics?.aircraft_in_maintenance}</li>
            <li>Pending Tasks: {status.metrics?.pending_maintenance_tasks}</li>
            <li>Low Stock Parts: {status.metrics?.low_stock_parts}</li>
          </ul>
          
          <p><small>Last updated: {status.timestamp}</small></p>
        </div>
      )}
    </div>
  );
}

export default App;