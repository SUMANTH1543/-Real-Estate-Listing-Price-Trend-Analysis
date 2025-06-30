# 🏘️ Real Estate Listing & Price Trend Analysis (SQL + Python)

This project focuses on analyzing real estate property listings using structured data stored in a MySQL database. The dataset was generated and preprocessed using Python and loaded into MySQL for analytical querying. The goal is to extract business-relevant insights such as price trends, investment opportunities, and market behavior using advanced SQL techniques.

---

## 📁 Project Structure

```
real-estate-sql-analysis/
├── real_estate_analysis.sql       # SQL queries and views
├── data.py            # Python script to generate CSVs
├── properties.csv                   # Property listing dataset
├── transactions.csv               # Property transaction dataset
└── README.md                      # Project overview and documentation
```

---

## 🛠️ Tools & Technologies
- **MySQL** for database design and querying
- **Python (Pandas, Faker)** to generate and clean CSV datasets
- **SQL**: JOINs, subqueries, GROUP BY, window functions, views

---

## 📌 Key Features

### ✅ Database Schema
- Two main tables: `properties` and `transactions`
- Over **50,000 listings** with fields like location, price, area, and listing date

### ✅ SQL Analytics
- Average price per square foot by city & property type
- Monthly pricing trends using window functions
- Fastest-selling regions and average time on market
- Views for city-wise KPIs and investment opportunity detection

### ✅ Business Insights Extracted
- Cities with highest 6-month price appreciation
- Neighborhoods with low time-on-market and high rental yield
- Category-wise inventory patterns and pricing volatility

---

## 🔍 Sample Queries Included
- `AVG(price / area)` by city
- Rolling 6-month `AVG(price)` using `OVER()` clause
- `JOIN` with transactions to compute market velocity
- Views for dashboards: `city_kpis`, `price_growth`, etc.

---

## 📦 Dataset Generation
- Python script (`generate_dataset.py`) generates realistic listing and transaction data
- Data is saved as `listings.csv` and `transactions.csv`
- Use any SQL client (MySQL Workbench, DBeaver) to import CSVs

---

## 🚀 Getting Started
1. Clone the repo:
2. Run `generate_dataset.py` to create the CSV files
3. Import CSVs into MySQL
4. Run `real_estate_analysis.sql` to build schema and execute queries

---

## 📈 Future Enhancements
- Streamlit or Power BI dashboard using SQL views
- Integrate GeoJSON for spatial analysis (heatmaps by region)
- Add rental pricing data for ROI comparison

---

## 📬 Contact
**Sumanth Godari**  
📧 godarisumanth1543@gmail.com  
🔗 [LinkedIn](https://linkedin.com/in/sumanth-godari)  
🔗 [GitHub](https://github.com/SUMANTH1543)

---

> ⭐ *If you find this project useful, give it a star and share it with others in the data community!*
