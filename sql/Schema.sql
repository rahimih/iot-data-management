-- Schema for IoT Data Management System
-- Create database
CREATE DATABASE iot_data;

-- Connect to the database
\c iot_data

create schema iot_data_s

set schema "iot_data_s"

-- Create devices table
CREATE TABLE devices (
    device_id SERIAL PRIMARY KEY,
    device_name VARCHAR(50) NOT NULL,
    location VARCHAR(100),
    created_at TIMESTAMP WITH TIME ZONE DEFAULT CURRENT_TIMESTAMP
);

-- Create sensor_readings table with partitioning by timestamp
CREATE TABLE sensor_readings (
    reading_id BIGSERIAL PRIMARY KEY,
    device_id INT REFERENCES devices(device_id),
    timestamp TIMESTAMP WITH TIME ZONE NOT NULL,
    temperature FLOAT NOT NULL,
    humidity FLOAT NOT NULL
) PARTITION BY RANGE (timestamp);

-- Create partitions for sensor_readings (e.g., monthly partitions)
CREATE TABLE sensor_readings_2025_09 PARTITION OF sensor_readings
    FOR VALUES FROM ('2025-09-01') TO ('2025-10-01');
CREATE TABLE sensor_readings_2025_10 PARTITION OF sensor_readings
    FOR VALUES FROM ('2025-10-01') TO ('2025-11-01');

-- Create indexes for performance
CREATE INDEX idx_sensor_readings_timestamp ON sensor_readings (timestamp);
CREATE INDEX idx_sensor_readings_device_id ON sensor_readings (device_id);
CREATE INDEX idx_sensor_readings_composite ON sensor_readings (device_id, timestamp);

-- Sample query for testing
INSERT INTO devices (device_name, location) VALUES ('Sensor_01', 'Room A');
INSERT INTO sensor_readings (device_id, timestamp, temperature, humidity)
VALUES (1, CURRENT_TIMESTAMP, 25.5, 55.0);