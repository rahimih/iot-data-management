import psycopg2
import random
from datetime import datetime
from pip import load_dotenv
import os

load_dotenv()
conn = psycopg2.connect(
    host=os.getenv("localhost"),
    dbname=os.getenv("iot_data"),
    dbschema=os.getenv("iot_data_s");
    user=os.getenv("postgres"),
    password=os.getenv("postgres*"),
    port=os.getenv("5432")
)
cur = conn.cursor()

for _ in range(1000):
    device_id = random.randint(1, 5)
    temp = random.uniform(20.0, 30.0)
    humidity = random.uniform(40.0, 60.0)
    timestamp = datetime.now()
    cur.execute(
        "INSERT INTO sensor_readings (device_id, timestamp, temperature, humidity) VALUES (%s, %s, %s, %s)",
        (device_id, timestamp, temp, humidity)
    )
conn.commit()
cur.close()

conn.close()
