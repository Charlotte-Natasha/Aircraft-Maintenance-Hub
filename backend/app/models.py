from .db import get_db_connection

def get_all_items():
    db = get_db_connection()
    cursor = db.cursor(dictionary=True)

    cursor.execute("SELECT * FROM aircraft_maintenance")
    results = cursor.fetchall()

    db.close()
    return results

def get_status_summary():
    db = get_db_connection()
    cursor = db.cursor(dictionary=True)

    cursor.execute("""
        SELECT status, COUNT(*) AS count
        FROM aircraft_maintenance
        GROUP BY status
    """)
    results = cursor.fetchall()

    db.close()
    return results
