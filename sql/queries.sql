-- Average temperature per device over the last day
SELECT d.device_name, AVG(r.temperature) as avg_temp
FROM sensor_readings r
JOIN devices d ON r.device_id = d.device_id
WHERE r.timestamp > NOW() - INTERVAL '1 day'
GROUP BY d.device_name;

-- Count readings per device
SELECT device_id, COUNT(*) as reading_count
FROM sensor_readings
GROUP BY device_id;