-- SQL Code Sheet: Real Estate Listing & Price Trend Analysis Project
✅ 1. Database & Table Creation
-- 1. Create tables
-- Table: locations
CREATE TABLE locations (
    location_id INT PRIMARY KEY,
    city VARCHAR(100),
    state VARCHAR(100),
    pincode VARCHAR(20),
    zone VARCHAR(20)
);

-- Table: agents
CREATE TABLE agents (
    agent_id INT PRIMARY KEY,
    name VARCHAR(100),
    email VARCHAR(100),
    phone VARCHAR(30)
);

-- Table: properties
CREATE TABLE properties (
    property_id INT PRIMARY KEY,
    location_id INT,
    agent_id INT,
    listing_date DATE,
    price DECIMAL(12, 2),
    bedrooms INT,
    bathrooms INT,
    sqft INT,
    status VARCHAR(20),
    FOREIGN KEY (location_id) REFERENCES locations(location_id),
    FOREIGN KEY (agent_id) REFERENCES agents(agent_id)
);

-- Table: sales
CREATE TABLE sales (
    sale_id INT PRIMARY KEY,
    property_id INT,
    sale_date DATE,
    sale_price DECIMAL(12,2),
    FOREIGN KEY (property_id) REFERENCES properties(property_id)
);

);

✅ 2. CSV Import (with LOCAL INFILE)

LOAD DATA LOCAL INFILE 'C:/path/locations.csv'
INTO TABLE locations
FIELDS TERMINATED BY ',' 
ENCLOSED BY '"'
LINES TERMINATED BY '\n'
IGNORE 1 ROWS;

LOAD DATA LOCAL INFILE 'C:/path/agents.csv'
INTO TABLE agents
FIELDS TERMINATED BY ',' 
ENCLOSED BY '"'
LINES TERMINATED BY '\n'
IGNORE 1 ROWS;

LOAD DATA LOCAL INFILE 'C:/path/properties.csv'
INTO TABLE properties
FIELDS TERMINATED BY ',' 
ENCLOSED BY '"'
LINES TERMINATED BY '\n'
IGNORE 1 ROWS;

LOAD DATA LOCAL INFILE 'C:/path/sales.csv'
INTO TABLE sales
FIELDS TERMINATED BY ',' 
ENCLOSED BY '"'
LINES TERMINATED BY '\n'
IGNORE 1 ROWS;

📊 3. Business Insight Queries
 🏙️ 3.1 Average Property Price by City
SELECT l.city, ROUND(AVG(p.price), 2) AS avg_price
FROM properties p
JOIN locations l ON p.location_id = l.location_id
GROUP BY l.city
ORDER BY avg_price DESC;

⏳ 3.2 Fastest Selling Properties (by days on market)
SELECT 
    p.property_id,
    DATEDIFF(s.sale_date, p.listing_date) AS days_on_market,
    s.sale_price,
    p.price AS listed_price,
    l.city
FROM properties p
JOIN sales s ON p.property_id = s.property_id
JOIN locations l ON p.location_id = l.location_id
ORDER BY days_on_market ASC
LIMIT 10;

📈 3.3 Price Trends Over Time (Monthly)
SELECT 
    DATE_FORMAT(s.sale_date, '%Y-%m') AS month,
    ROUND(AVG(s.sale_price), 2) AS avg_monthly_price
FROM sales s
GROUP BY month
ORDER BY month;

👨‍💼 3.4 Top 5 Performing Agents by Number of Properties Sold

SELECT 
    a.agent_id,
    a.name,
    COUNT(*) AS properties_sold
FROM agents a
JOIN properties p ON a.agent_id = p.agent_id
JOIN sales s ON p.property_id = s.property_id
GROUP BY a.agent_id, a.name
ORDER BY properties_sold DESC
LIMIT 5;

🏘️ 3.5 Property Status Breakdown
SELECT status, COUNT(*) AS count
FROM properties
GROUP BY status;

🌍 3.6 City-wise Sales Count and Total Revenue
SELECT 
    l.city,
    COUNT(s.sale_id) AS total_sales,
    ROUND(SUM(s.sale_price), 2) AS total_revenue
FROM sales s
JOIN properties p ON s.property_id = p.property_id
JOIN locations l ON p.location_id = l.location_id
GROUP BY l.city
ORDER BY total_revenue DESC;

🧾 4. Bonus: Create a View for Reuse
CREATE VIEW city_price_trends AS
SELECT 
    l.city,
    DATE_FORMAT(s.sale_date, '%Y-%m') AS month,
    ROUND(AVG(s.sale_price), 2) AS avg_price
FROM sales s
JOIN properties p ON s.property_id = p.property_id
JOIN locations l ON p.location_id = l.location_id
GROUP BY l.city, month;

-- Example usage:
SELECT * FROM city_price_trends WHERE city = 'New York';

🧠 Summary:
Project Name: Real Estate Listing & Price Trend Analysis
Tools Used: MySQL, Python (Faker for data generation)
Skills Highlighted:
SQL joins, grouping, filtering, views
Business trend analysis
Data cleaning and loading automation
Data modeling and relationship design
