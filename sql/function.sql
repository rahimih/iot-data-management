set schema 'iot_data_s';

CREATE OR REPLACE FUNCTION create_partition_if_not_exists()
RETURNS TRIGGER AS $$
DECLARE
    partition_name TEXT;
    start_date DATE;
    end_date DATE;
BEGIN
    -- Extract year and month from timestamp
    start_date := date_trunc('month', NEW.timestamp);
    end_date := start_date + INTERVAL '1 month';

    partition_name := 'sensor_readings_' || to_char(start_date, 'YYYY_MM');

    -- Check if partition exists
    IF NOT EXISTS (
        SELECT 1 FROM pg_tables
        WHERE schemaname = 'iot_data_s' AND tablename = partition_name
    ) THEN
        EXECUTE format(
            'CREATE TABLE %I PARTITION OF sensor_readings FOR VALUES FROM (%L) TO (%L)',
            partition_name, start_date, end_date
        );
    END IF;

    RETURN NEW;
END;
$$ LANGUAGE plpgsql;

-- Attach trigger
CREATE TRIGGER partition_trigger
    BEFORE INSERT ON sensor_readings
    FOR EACH ROW
    EXECUTE FUNCTION create_partition_if_not_exists();