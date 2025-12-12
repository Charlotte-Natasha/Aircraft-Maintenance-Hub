import { useState } from "react";
import AircraftTable from "./Aircraft";
import MaintenanceTable from "./Maintenance";
import PartsInventoryTable from "./Parts";

function Tabs() {
  const [activeTab, setActiveTab] = useState("aircraft");

  return (
    <section className="tabs-section">
      <div className="container">
        <div className="tabs">
          <button 
            className={`tab ${activeTab === "aircraft" ? "active" : ""}`}
            onClick={() => setActiveTab("aircraft")}
          >
            Aircraft Fleet
          </button>
          
          <button 
            className={`tab ${activeTab === "tasks" ? "active" : ""}`}
            onClick={() => setActiveTab("tasks")}
          >
            Maintenance Tasks
          </button>
          
          <button 
            className={`tab ${activeTab === "parts" ? "active" : ""}`}
            onClick={() => setActiveTab("parts")}
          >
            Parts Inventory
          </button>
        </div>

        {/* Content Area */}
        <div className="tab-content">
          {activeTab === "aircraft" && <AircraftTable />}
          {activeTab === "tasks" && <MaintenanceTable />}
          {activeTab === "parts" && <PartsInventoryTable />}
        </div>
      </div>
    </section>
  );
}

export default Tabs;
