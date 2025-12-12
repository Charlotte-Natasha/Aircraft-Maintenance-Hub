import { useEffect, useState } from "react";

function PartsInventoryTable() {
  const [items, setItems] = useState([]);
  const [loading, setLoading] = useState(true);

  useEffect(() => {
    async function fetchItems() {
      try {
        const response = await fetch("http://localhost:8000/items");
        const data = await response.json();
        setItems(data.items); // <-- matches your backend JSON
      } catch (error) {
        console.error("Error fetching parts inventory:", error);
      } finally {
        setLoading(false);
      }
    }

    fetchItems();
  }, []);

  if (loading) return <p>Loading parts inventory...</p>;

  return (
    <table className="data-table">
      <thead>
        <tr>
          <th>Part Number</th>
          <th>Name</th>
          <th>Category</th>
          <th>Quantity</th>
          <th>Minimum Qty</th>
          <th>Unit Price</th>
          <th>Location</th>
          <th>Expiry Date</th>
        </tr>
      </thead>
      <tbody>
        {items.map((item) => (
          <tr key={item.id}>
            <td>{item.part_number}</td>
            <td>{item.part_name}</td>
            <td>{item.part_category}</td>
            <td>{item.quantity}</td>
            <td>{item.minimum_quantity}</td>
            <td>{item.unit_price}</td>
            <td>{item.location}</td>
            <td>{item.expiry_date || "-"}</td> {/* show '-' if expiry_date is null */}
          </tr>
        ))}
      </tbody>
    </table>
  );
}

export default PartsInventoryTable;
