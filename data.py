import pandas as pd
import random
from faker import Faker
from datetime import datetime, timedelta

fake = Faker()

# Constants
NUM_LOCATIONS = 10
NUM_AGENTS = 20
NUM_PROPERTIES = 500
SALE_PROBABILITY = 0.7  # 70% of properties are sold

# -----------------------
# 1. Generate Locations
# -----------------------
location_ids = list(range(1, NUM_LOCATIONS + 1))
cities = [fake.city() for _ in range(NUM_LOCATIONS)]
states = [fake.state() for _ in range(NUM_LOCATIONS)]
pincodes = [fake.postcode() for _ in range(NUM_LOCATIONS)]
zones = [random.choice(['North', 'South', 'East', 'West', 'Central']) for _ in range(NUM_LOCATIONS)]

locations_df = pd.DataFrame({
    'location_id': location_ids,
    'city': cities,
    'state': states,
    'pincode': pincodes,
    'zone': zones
})

# --------------------
# 2. Generate Agents
# --------------------
agent_ids = list(range(1, NUM_AGENTS + 1))
agent_names = [fake.name() for _ in range(NUM_AGENTS)]
emails = [fake.email() for _ in range(NUM_AGENTS)]
phones = [fake.phone_number() for _ in range(NUM_AGENTS)]

agents_df = pd.DataFrame({
    'agent_id': agent_ids,
    'name': agent_names,
    'email': emails,
    'phone': phones
})

# ------------------------
# 3. Generate Properties
# ------------------------
properties = []
for i in range(1, NUM_PROPERTIES + 1):
    location_id = random.choice(location_ids)
    agent_id = random.choice(agent_ids)
    listing_date = fake.date_between(start_date='-1y', end_date='-10d')
    bedrooms = random.randint(1, 5)
    bathrooms = random.randint(1, 3)
    sqft = random.randint(500, 3000)
    price = sqft * random.randint(50, 200)  # per sqft price
    status = 'Sold' if random.random() < SALE_PROBABILITY else 'Available'

    properties.append([
        i, location_id, agent_id, listing_date, price,
        bedrooms, bathrooms, sqft, status
    ])

properties_df = pd.DataFrame(properties, columns=[
    'property_id', 'location_id', 'agent_id', 'listing_date', 'price',
    'bedrooms', 'bathrooms', 'sqft', 'status'
])

# ---------------------
# 4. Generate Sales
# ---------------------
# ---------------------
# 4. Generate Sales
# ---------------------
sales = []
sale_id = 1
for idx, row in properties_df[properties_df['status'] == 'Sold'].iterrows():
    sale_date = row['listing_date'] + timedelta(days=random.randint(5, 90))
    sale_price = row['price'] * random.uniform(0.95, 1.05)

    sales.append([
        sale_id, row['property_id'], sale_date, round(sale_price, 2)
    ])
    sale_id += 1


sales_df = pd.DataFrame(sales, columns=[
    'sale_id', 'property_id', 'sale_date', 'sale_price'
])

# -------------------------
# 5. Export to CSV
# -------------------------
locations_df.to_csv("locations.csv", index=False)
agents_df.to_csv("agents.csv", index=False)
properties_df.to_csv("properties.csv", index=False)
sales_df.to_csv("sales.csv", index=False)

print("✅ CSVs generated: locations.csv, agents.csv, properties.csv, sales.csv")
