-- SQL Code Sheet: Real Estate Listing & Price Trend Analysis Project

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

-- 2. Clean nulls and duplicates
DELETE FROM properties WHERE property_id IS NULL;
DELETE FROM transactions WHERE transaction_id IS NULL;

-- 3. Average price per sqft by city
SELECT 
    city,
    ROUND(AVG(price / area_sqft), 2) AS avg_price_per_sqft
FROM properties
GROUP BY city
ORDER BY avg_price_per_sqft DESC;

-- 4. Top 5 cities with rising average prices month over month
SELECT city, 
       DATE_FORMAT(listed_date, '%Y-%m') AS month,
       ROUND(AVG(price), 2) AS avg_price
FROM properties
GROUP BY city, month
ORDER BY city, month;

-- 5. Price trend using window function
SELECT 
    city,
    listed_date,
    price,
    ROUND(AVG(price) OVER (PARTITION BY city ORDER BY listed_date ROWS BETWEEN 6 PRECEDING AND CURRENT ROW), 2) AS rolling_avg_price
FROM properties;

-- 6. Fastest selling regions
SELECT 
    city,
    AVG(DATEDIFF(sale_date, listed_date)) AS avg_days_on_market
FROM properties p
JOIN transactions t ON p.property_id = t.property_id
GROUP BY city
ORDER BY avg_days_on_market ASC
LIMIT 5;

-- 7. View for latest KPIs by city
CREATE VIEW city_kpis AS
SELECT 
    city,
    COUNT(*) AS total_listings,
    ROUND(AVG(price), 2) AS avg_listing_price,
    ROUND(AVG(price / area_sqft), 2) AS avg_price_per_sqft
FROM properties
GROUP BY city;

-- 8. Identify top investment cities by price growth
WITH city_growth AS (
    SELECT city,
           DATE_FORMAT(listed_date, '%Y-%m') AS month,
           AVG(price) AS avg_price
    FROM properties
    GROUP BY city, month
)
SELECT city,
       MAX(avg_price) - MIN(avg_price) AS price_growth
FROM city_growth
GROUP BY city
ORDER BY price_growth DESC
LIMIT 5;
