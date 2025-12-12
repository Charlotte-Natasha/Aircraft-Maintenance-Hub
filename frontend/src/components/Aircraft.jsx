import { useEffect, useState } from "react";

function AircraftTable() {
  const [aircraft, setAircraft] = useState([]);
  const [loading, setLoading] = useState(true);

  useEffect(() => {
    async function fetchAircraft() {
      try {
        const response = await fetch("http://localhost:8000/aircraft");
        const data = await response.json();
        setAircraft(data.aircraft); // <-- use data.aircraft, not data
      } catch (error) {
        console.error("Error fetching aircraft:", error);
      } finally {
        setLoading(false);
      }
    }

    fetchAircraft();
  }, []);

  if (loading) return <p>Loading aircraft...</p>;

  return (
    <table className="data-table">
      <thead>
        <tr>
          <th>Registration</th>
          <th>Manufacturer</th>
          <th>Model</th>
          <th>Total Hours</th>
          <th>Status</th>
        </tr>
      </thead>

      <tbody>
        {aircraft.map((ac) => (
          <tr key={ac.id}>
            <td>{ac.tail_number}</td>
            <td>{ac.manufacturer}</td>
            <td>{ac.model}</td>
            <td>{ac.total_hours}</td>
            <td>{ac.status}</td>
          </tr>
        ))}
      </tbody>
    </table>
  );
}

export default AircraftTable;
