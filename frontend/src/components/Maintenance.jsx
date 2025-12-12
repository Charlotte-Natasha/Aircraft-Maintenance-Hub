import { useEffect, useState } from "react";

function MaintenanceTable() {
  const [tasks, setTasks] = useState([]);
  const [loading, setLoading] = useState(true);

  useEffect(() => {
    async function fetchTasks() {
      try {
        const response = await fetch("http://localhost:8000/tasks");
        const data = await response.json();
        setTasks(data.tasks); // <-- same pattern as Aircraft
      } catch (error) {
        console.error("Error fetching maintenance tasks:", error);
      } finally {
        setLoading(false);
      }
    }

    fetchTasks();
  }, []);

  if (loading) return <p>Loading maintenance tasks...</p>;

  return (
    <table className="data-table">
      <thead>
        <tr>
          <th>Tail Number</th>
          <th>Task Type</th>
          <th>Description</th>
          <th>Mechanic</th>
          <th>Scheduled Date</th>
          <th>Completed Date</th>
          <th>Status</th>
          <th>Priority</th>
        </tr>
      </thead>
      <tbody>
        {tasks.map((task) => (
          <tr key={task.id}>
            <td>{task.tail_number}</td>
            <td>{task.task_type}</td>
            <td>{task.description}</td>
            <td>{task.mechanic_name}</td>
            <td>{task.scheduled_date}</td>
            <td>{task.completed_date}</td>
            <td>{task.status}</td>
            <td>{task.priority}</td>
          </tr>
        ))}
      </tbody>
    </table>
  );
}

export default MaintenanceTable;
