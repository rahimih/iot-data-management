from flask import Flask, render_template
import psycopg2
from dotenv import load_dotenv
import os

app = Flask(__name__)
load_dotenv()

def get_db_connection():
    return psycopg2.connect(
        host=os.getenv("DB_HOST"),
        dbname=os.getenv("DB_NAME"),
        user=os.getenv("DB_USER"),
        password=os.getenv("DB_PASSWORD"),
        port=os.getenv("DB_PORT"),
         options="-c search_path=iot_data_s"
    )

@app.route('/')
def dashboard():
    conn = get_db_connection()
    cur = conn.cursor()
    cur.execute("""
        SELECT d.device_name, AVG(r.temperature) as avg_temp
        FROM sensor_readings r
        JOIN devices d ON r.device_id = d.device_id
        GROUP BY d.device_name
    """)
    data = cur.fetchall()
    cur.close()
    conn.close()
    return render_template('dashboard.html', data=data)

if __name__ == '__main__':
    app.run(debug=True)