import React from 'react';

function AircraftTable() {
  return (
    <div className="table-container">
      <table className="data-table">
        <thead>
          <tr>
            <th>Tail Number</th>
            <th>Model</th>
            <th>Manufacturer</th>
            <th>Total Hours</th>
            <th>Total Cycles</th>
            <th>Status</th>
            <th>Last Inspection</th>
          </tr>
        </thead>
        <tbody>
          {/* Placeholder rows */}
          <tr>
            <td>N12345</td>
            <td>Boeing 737-800</td>
            <td>Boeing</td>
            <td>15,234</td>
            <td>8,456</td>
            <td>Serviceable</td>
            <td>2025-11-15</td>
          </tr>
          <tr>
            <td>N67890</td>
            <td>Airbus A320</td>
            <td>Airbus</td>
            <td>22,100</td>
            <td>11,234</td>
            <td>Maintenance</td>
            <td>2025-10-20</td>
          </tr>
          <tr>
            <td>N11111</td>
            <td>Boeing 777-300ER</td>
            <td>Boeing</td>
            <td>45,678</td>
            <td>12,345</td>
            <td>Serviceable</td>
            <td>2025-11-01</td>
          </tr>
        </tbody>
      </table>
    </div>
  );
}

export default AircraftTable;