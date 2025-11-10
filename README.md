# Real-Time IoT Data Management System

## Overview
This project is a scalable, real-time IoT data management system built with PostgreSQL, Python, and Flask. It collects, stores, and analyzes sensor data (e.g., temperature, humidity) from IoT devices, optimized for high-frequency data ingestion and efficient querying. The system is deployed on Azure for accessibility and includes a web dashboard for visualization.

### Features
- **Database Design**: Relational schema with partitioning and indexing for performance.
- **Data Ingestion**: Python script to simulate IoT sensor data ingestion.
- **Query Optimization**: Reduced query execution time by 60% using composite indexes (see `sql/optimization_notes.md`).
- **Visualization**: Flask-based dashboard (or Power BI integration) for real-time metrics.
- **Deployment**: Hosted on Azure Database for PostgreSQL and Azure App Service.

### Tech Stack
- **Database**: PostgreSQL (Azure Database for PostgreSQL)
- **Backend**: Python, Flask
- **Cloud**: Azure
- **Optional**: Microsoft Fabric (Power BI for analytics)

### Database Schema
- **devices**: Stores device metadata (ID, name, location).
- **sensor_readings**: Time-series data with range partitioning by month.
  ![ER Diagram](ER_diagram.png)

### Setup Instructions
1. **Clone the Repository**:
   ```bash
   git clone https://github.com/rahimih/iot-data-management.git
   cd iot-data-management
