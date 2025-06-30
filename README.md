# 🏠 Real Estate Listing & Price Trend Analysis

A full-scale data analytics project simulating a real-world real estate listing platform. This project demonstrates my ability to design relational schemas, generate realistic datasets, import data into MySQL, and extract business insights using complex SQL queries.

---

## 📌 Project Objectives

- Design a relational database for a real estate system
- Generate synthetic real estate data using Python and Faker
- Import and manage data in MySQL
- Analyze price trends, agent performance, sales velocity, and market distribution using SQL
- Prepare a query-ready database to support business decisions

---

## 📁 Dataset Structure

Generated using a custom Python script (`data_generator.py`), the project simulates 500 property listings across various cities and zones.

| Table       | Description                                   |
|-------------|-----------------------------------------------|
| `locations` | City, state, pincode, zone classification     |
| `agents`    | Agent contact information                     |
| `properties`| Property details like price, size, listing date, etc. |
| `sales`     | Sale information for sold properties          |

---

## 🛠️ Technologies Used

- **Python** (Faker, Pandas) – for synthetic data generation
- **MySQL Workbench** – for relational schema and data import
- **SQL** – for analytical querying
- *(Optional)* Tableau / Streamlit – for future dashboarding

---

## 🔧 Setup Instructions

### 1. Clone the repository

### 2. Generate data using Python
python data.py
### This will generate:
locations.csv
agents.csv
properties.csv
sales.csv

### 3. Workbench and run:
CREATE DATABASE real_estate_db;
USE real_estate_db;

### Then run the create_tables.sql file to create all tables.
### 4. Import CSV files
Make sure local_infile is enabled:
SET GLOBAL local_infile = 1;

### Then load data using:
LOAD DATA LOCAL INFILE 'absolute/path/to/locations.csv'
INTO TABLE locations
FIELDS TERMINATED BY ',' ENCLOSED BY '"' LINES TERMINATED BY '\n' IGNORE 1 ROWS;
