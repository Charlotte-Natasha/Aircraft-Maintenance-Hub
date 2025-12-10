from flask import Blueprint, jsonify
from .db import get_db_connection
from psycopg2.extras import RealDictCursor

api = Blueprint("api", __name__)

# --- Home & Status ---
@api.route("/")
def home():
    return jsonify({"message": "Welcome to the Aircraft Maintenance API"})

@api.route("/status")
def status():
    return jsonify({"message": "OK"})

# --- Aircraft ---
@api.route("/aircraft")
def get_aircraft():
    conn = get_db_connection()
    try:
        with conn.cursor(cursor_factory=RealDictCursor) as cur:
            cur.execute("""
                SELECT id, 
                tail_number, 
                model, 
                manufacturer, 
                status, 
                total_hours, 
                total_cycles, 
                last_inspection
                FROM aircraft
                ORDER BY id;
            """)
            rows = cur.fetchall()
            return jsonify({"aircraft": rows})
    finally:
        conn.close()

# --- Maintenance Tasks ---
@api.route("/tasks")
def get_tasks():
    conn = get_db_connection()
    try:
        with conn.cursor(cursor_factory=RealDictCursor) as cur:
            cur.execute("""
                SELECT t.id, 
                a.tail_number, 
                t.task_type, 
                t.description, 
                t.status, 
                t.priority,
                t.scheduled_date, 
                t.completed_date, 
                t.mechanic_name
                FROM maintenance_tasks t
                JOIN aircraft a ON t.aircraft_id = a.id
                ORDER BY t.scheduled_date;
            """)
            rows = cur.fetchall()
            return jsonify({"tasks": rows})
    finally:
        conn.close()

# --- Parts Inventory ---
@api.route("/items")
def get_items():
    conn = get_db_connection()
    try:
        with conn.cursor(cursor_factory=RealDictCursor) as cur:
            cur.execute("""
                SELECT id, 
                part_number, 
                part_name, 
                part_category, 
                quantity, 
                minimum_quantity,
                unit_price, 
                location, 
                expiry_date
                FROM parts_inventory
                ORDER BY id;
            """)
            rows = cur.fetchall()
            return jsonify({"items": rows})
    finally:
        conn.close()

# --- Maintenance Logs ---
@api.route("/logs")
def get_logs():
    conn = get_db_connection()
    try:
        with conn.cursor(cursor_factory=RealDictCursor) as cur:
            cur.execute("""
                SELECT l.id, 
                a.tail_number, 
                t.task_type, 
                l.log_date, 
                l.description, 
                l.log_type,
                l.hours_recorded, 
                l.mechanic_signature
                FROM maintenance_logs l
                JOIN aircraft a ON l.aircraft_id = a.id
                LEFT JOIN maintenance_tasks t ON l.task_id = t.id
                ORDER BY l.log_date DESC;
            """)
            rows = cur.fetchall()
            return jsonify({"logs": rows})
    finally:
        conn.close()

# --- Global Error Handler ---
@api.errorhandler(Exception)
def handle_error(e):
    return jsonify({"error": str(e)}), 500