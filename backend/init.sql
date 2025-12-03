-- Database Initialization

-- Drop existing tables (for clean restarts)
DROP TABLE IF EXISTS maintenance_logs CASCADE;
DROP TABLE IF EXISTS maintenance_tasks CASCADE;
DROP TABLE IF EXISTS parts_inventory CASCADE;
DROP TABLE IF EXISTS aircraft CASCADE;

-- Create Tables

-- Aircraft Table
CREATE TABLE aircraft (
    id SERIAL PRIMARY KEY,
    tail_number VARCHAR(10) NOT NULL UNIQUE,
    model VARCHAR(50) NOT NULL,
    manufacturer VARCHAR(50),
    total_hours INTEGER DEFAULT 0,
    total_cycles INTEGER DEFAULT 0,
    status VARCHAR(20) DEFAULT 'serviceable',
    last_inspection DATE,
    created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP
);

-- Maintenance Tasks Table
CREATE TABLE maintenance_tasks (
    id SERIAL PRIMARY KEY,
    aircraft_id INTEGER NOT NULL,
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
    id SERIAL PRIMARY KEY,
    part_number VARCHAR(50) NOT NULL UNIQUE,
    part_name VARCHAR(100) NOT NULL,
    quantity INTEGER DEFAULT 0,
    minimum_quantity INTEGER DEFAULT 10,
    unit_price DECIMAL(10,2),
    location VARCHAR(50),
    expiry_date DATE,
    created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP
);

-- Maintenance Logs Table
CREATE TABLE maintenance_logs (
    id SERIAL PRIMARY KEY,
    aircraft_id INTEGER NOT NULL,
    task_id INTEGER,
    log_date TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    description TEXT NOT NULL,
    hours_recorded DECIMAL(8,1),
    mechanic_signature VARCHAR(100),
    FOREIGN KEY (aircraft_id) REFERENCES aircraft(id) ON DELETE CASCADE,
    FOREIGN KEY (task_id) REFERENCES maintenance_tasks(id) ON DELETE SET NULL
);

-- Insert Sample Data

-- Sample Aircraft
INSERT INTO aircraft (tail_number, model, manufacturer, total_hours, total_cycles, status, last_inspection) VALUES
('N12345', 'Boeing 737-800', 'Boeing', 15234, 8456, 'serviceable', '2024-11-15'),
('N67890', 'Airbus A320-200', 'Airbus', 22100, 11234, 'maintenance', '2024-10-20'),
('N11111', 'Boeing 777-300ER', 'Boeing', 45678, 12345, 'serviceable', '2024-11-01'),
('N22222', 'Airbus A350-900', 'Airbus', 8900, 4523, 'serviceable', '2024-11-25'),
('N33333', 'Boeing 787-9', 'Boeing', 12456, 6789, 'grounded', '2024-09-15'),
('N44444', 'Cessna 172', 'Cessna', 3456, 2890, 'serviceable', '2024-11-20'),
('N55555', 'Bombardier CRJ-900', 'Bombardier', 18234, 9876, 'serviceable', '2024-11-10'),
('N66666', 'Embraer E190', 'Embraer', 16789, 8543, 'maintenance', '2024-11-05');

-- Sample Maintenance Tasks
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

-- Sample Parts
INSERT INTO parts_inventory (part_number, part_name, quantity, minimum_quantity, unit_price, location) VALUES
('ENG-001', 'Turbine Blade Set', 5, 3, 45000.00, 'Warehouse A'),
('TIRE-737', 'Boeing 737 Main Landing Gear Tire', 12, 8, 2500.00, 'Warehouse B'),
('HYDR-PUMP', 'Hydraulic Pump Assembly', 3, 5, 8900.00, 'Warehouse A'),
('OIL-FILTER', 'Engine Oil Filter', 45, 20, 150.00, 'Warehouse C'),
('BRAKE-PAD', 'Aircraft Brake Pad Set', 18, 10, 1200.00, 'Warehouse B'),
('NAV-DISPLAY', 'Navigation Display Unit', 2, 3, 15000.00, 'Warehouse A'),
('WIPER-BLADE', 'Windshield Wiper Blade', 30, 15, 85.00, 'Warehouse C'),
('APU-BATTERY', 'APU Start Battery', 8, 5, 3500.00, 'Warehouse A'),
('OXYGEN-MASK', 'Passenger Oxygen Mask', 150, 100, 45.00, 'Warehouse C'),
('CABIN-LIGHT', 'LED Cabin Light Assembly', 60, 30, 120.00, 'Warehouse B');

-- Sample Maintenance Logs
INSERT INTO maintenance_logs (aircraft_id, task_id, description, hours_recorded, mechanic_signature) VALUES
(1, 1, 'Completed routine visual inspection of airframe', 15234.5, 'John Smith'),
(2, 2, 'Removed left engine for overhaul', 22100.0, 'John Smith'),
(4, 5, 'Successfully updated avionics software to version 5.2', 8900.3, 'Sarah Johnson'),
(5, 6, 'Identified structural crack in fuselage frame 45', 12456.7, 'Mike Davis'),
(1, 4, 'Inspected landing gear, found wear on strut bushings', 15235.2, 'Mike Davis');



CREATE INDEX idx_aircraft_status ON aircraft(status);
CREATE INDEX idx_tasks_status ON maintenance_tasks(status);
CREATE INDEX idx_tasks_aircraft ON maintenance_tasks(aircraft_id);
CREATE INDEX idx_parts_quantity ON parts_inventory(quantity);