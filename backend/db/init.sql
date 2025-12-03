-- Aircraft Maintenance Tracker - MySQL Init


-- Drop existing tables (for clean restarts)
DROP TABLE IF EXISTS maintenance_logs;
DROP TABLE IF EXISTS maintenance_tasks;
DROP TABLE IF EXISTS parts_inventory;
DROP TABLE IF EXISTS aircraft;

-- Create Tables

-- Aircraft Table
CREATE TABLE aircraft (
    id INT AUTO_INCREMENT PRIMARY KEY,
    tail_number VARCHAR(10) NOT NULL UNIQUE,
    model VARCHAR(50) NOT NULL,
    manufacturer VARCHAR(50),
    total_hours INT DEFAULT 0,
    total_cycles INT DEFAULT 0,
    status VARCHAR(20) DEFAULT 'serviceable',
    last_inspection DATE,
    created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP
);

-- Maintenance Tasks Table
CREATE TABLE maintenance_tasks (
    id INT AUTO_INCREMENT PRIMARY KEY,
    aircraft_id INT NOT NULL,
    task_type VARCHAR(50) NOT NULL,
    description TEXT,
    status VARCHAR(20) DEFAULT 'pending',
    priority VARCHAR(20) DEFAULT 'medium',
    scheduled_date DATE,
    completed_date DATE,
    mechanic_name VARCHAR(100),
    created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    FOREIGN KEY (aircraft_id) REFERENCES aircraft(id) ON DELETE CASCADE
);

-- Parts Inventory Table
CREATE TABLE parts_inventory (
    id INT AUTO_INCREMENT PRIMARY KEY,
    part_number VARCHAR(50) NOT NULL UNIQUE,
    part_name VARCHAR(100) NOT NULL,
    part_category VARCHAR(50) DEFAULT 'general',  
    quantity INT DEFAULT 0,
    minimum_quantity INT DEFAULT 10,
    unit_price DECIMAL(10,2),
    location VARCHAR(50),
    expiry_date DATE,
    created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP
);

-- Maintenance Logs Table
CREATE TABLE maintenance_logs (
    id INT AUTO_INCREMENT PRIMARY KEY,
    aircraft_id INT NOT NULL,
    task_id INT,
    log_date TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    description TEXT NOT NULL,
    log_type VARCHAR(50) DEFAULT 'inspection',  
    hours_recorded DECIMAL(8,1),
    mechanic_signature VARCHAR(100),
    FOREIGN KEY (aircraft_id) REFERENCES aircraft(id) ON DELETE CASCADE,
    FOREIGN KEY (task_id) REFERENCES maintenance_tasks(id) ON DELETE SET NULL
);

-- Insert Sample Aircraft

INSERT INTO aircraft (tail_number, model, manufacturer, total_hours, total_cycles, status, last_inspection) VALUES
('N12345', 'Boeing 737-800', 'Boeing', 15234, 8456, 'serviceable', '2024-11-15'),
('N67890', 'Airbus A320-200', 'Airbus', 22100, 11234, 'maintenance', '2024-10-20'),
('N11111', 'Boeing 777-300ER', 'Boeing', 45678, 12345, 'serviceable', '2024-11-01'),
('N22222', 'Airbus A350-900', 'Airbus', 8900, 4523, 'serviceable', '2024-11-25'),
('N33333', 'Boeing 787-9', 'Boeing', 12456, 6789, 'grounded', '2024-09-15'),
('N44444', 'Cessna 172', 'Cessna', 3456, 2890, 'serviceable', '2024-11-20'),
('N55555', 'Bombardier CRJ-900', 'Bombardier', 18234, 9876, 'serviceable', '2024-11-10'),
('N66666', 'Embraer E190', 'Embraer', 16789, 8543, 'maintenance', '2024-11-05'),
('N77777', 'Beechcraft Bonanza G36', 'Beechcraft', 1200, 800, 'serviceable', '2024-11-18'),
('N88888', 'Piper PA-28 Cherokee', 'Piper', 900, 500, 'serviceable', '2024-11-10'),
('N99999', 'Diamond DA40', 'Diamond', 500, 300, 'serviceable', '2024-11-12');

-- Insert Sample Maintenance Tasks

INSERT INTO maintenance_tasks (aircraft_id, task_type, description, status, priority, scheduled_date, mechanic_name) VALUES
(1, 'A-Check', 'Routine inspection due at 15500 hours', 'pending', 'high', '2024-12-15', NULL),
(2, 'Engine Overhaul', 'Left engine requires major inspection', 'in_progress', 'critical', '2024-12-01', 'John Smith'),
(3, 'B-Check', 'Scheduled heavy maintenance', 'pending', 'medium', '2025-01-10', NULL),
(1, 'Landing Gear Service', 'Annual landing gear inspection', 'pending', 'medium', '2024-12-20', NULL),
(4, 'Avionics Update', 'Software update for navigation system', 'completed', 'low', '2024-11-28', 'Sarah Johnson'),
(5, 'Structural Inspection', 'Fuselage crack inspection', 'in_progress', 'critical', '2024-12-05', 'Mike Davis'),
(6, 'Oil Change', 'Engine oil and filter replacement', 'pending', 'low', '2024-12-18', NULL),
(7, 'Tire Replacement', 'Replace worn main gear tires', 'pending', 'high', '2024-12-12', NULL),
(8, 'Hydraulic System', 'Hydraulic fluid leak repair', 'in_progress', 'high', '2024-12-03', 'John Smith');

-- Insert Sample Parts

INSERT INTO parts_inventory (part_number, part_name, part_category, quantity, minimum_quantity, unit_price, location) VALUES
('ENG-001', 'Turbine Blade Set', 'engine', 5, 3, 45000.00, 'Warehouse A'),
('TIRE-737', 'Boeing 737 Main Landing Gear Tire', 'landing gear', 12, 8, 2500.00, 'Warehouse B'),
('HYDR-PUMP', 'Hydraulic Pump Assembly', 'hydraulic', 3, 5, 8900.00, 'Warehouse A'),
('OIL-FILTER', 'Engine Oil Filter', 'engine', 45, 20, 150.00, 'Warehouse C'),
('BRAKE-PAD', 'Aircraft Brake Pad Set', 'brakes', 18, 10, 1200.00, 'Warehouse B'),
('NAV-DISPLAY', 'Navigation Display Unit', 'avionics', 2, 3, 15000.00, 'Warehouse A'),
('WIPER-BLADE', 'Windshield Wiper Blade', 'general', 30, 15, 85.00, 'Warehouse C'),
('APU-BATTERY', 'APU Start Battery', 'electrical', 8, 5, 3500.00, 'Warehouse A'),
('OXYGEN-MASK', 'Passenger Oxygen Mask', 'safety', 150, 100, 45.00, 'Warehouse C'),
('CABIN-LIGHT', 'LED Cabin Light Assembly', 'lighting', 60, 30, 120.00, 'Warehouse B');


-- Insert Sample Maintenance Logs

INSERT INTO maintenance_logs (aircraft_id, task_id, description, log_type, hours_recorded, mechanic_signature) VALUES
(1, 1, 'Completed routine visual inspection of airframe', 'inspection', 15234.5, 'John Smith'),
(2, 2, 'Removed left engine for overhaul', 'repair', 22100.0, 'John Smith'),
(4, 5, 'Successfully updated avionics software to version 5.2', 'software update', 8900.3, 'Sarah Johnson'),
(5, 6, 'Identified structural crack in fuselage frame 45', 'inspection', 12456.7, 'Mike Davis'),
(1, 4, 'Inspected landing gear, found wear on strut bushings', 'inspection', 15235.2, 'Mike Davis');

-- Indexes

CREATE INDEX idx_aircraft_status ON aircraft(status);
CREATE INDEX idx_tasks_status ON maintenance_tasks(status);
CREATE INDEX idx_tasks_aircraft ON maintenance_tasks(aircraft_id);
CREATE INDEX idx_parts_quantity ON parts_inventory(quantity);
