import pandas as pd
from faker import Faker
import random

# Initialize Faker
fake = Faker()

num_records = 100

def raw_policyholders():

# Generate dummy data
    data = {
        'policyholder_id': [random.randint(1, 10000) for _ in range(num_records)],
        'first_name': [fake.first_name() for _ in range(num_records)],
        'last_name': [fake.last_name() for _ in range(num_records)],
        'birthdate': [fake.date_of_birth(minimum_age=18, maximum_age=90).strftime('%Y-%m-%d') for _ in range(num_records)],
        'address': [fake.address().replace("\n", ", ") for _ in range(num_records)],
    }

    df = pd.DataFrame(data)
# Save to CSV
    df.to_csv('raw_policyholders.csv', index=False)



def raw_policy():
    data_policies = {
        'policy_id': [random.randint(1, 10000) for _ in range(num_records)],
        'policyholder_id': [random.randint(1, 10000) for _ in range(num_records)],
        'policy_type': [random.choice(['Life', 'Health', 'Auto', 'Home', 'Travel']) for _ in range(num_records)],
        'start_date': [fake.date_between(start_date="-5y", end_date="today").strftime('%Y-%m-%d') for _ in range(num_records)],
        'end_date': [fake.date_between(start_date="today", end_date="+5y").strftime('%Y-%m-%d') for _ in range(num_records)],
        'premium': [round(random.uniform(100, 1000), 2) for _ in range(num_records)],
    }

    df_policies = pd.DataFrame(data_policies)
    df_policies.to_csv('raw_policies.csv', index=False)



def raw_claims():

    data_claims = {
        'claim_id': [random.randint(1, 10000) for _ in range(num_records)],
        'policy_id': [random.randint(1, 10000) for _ in range(num_records)],
        'date_of_claim': [fake.date_between(start_date="-3y", end_date="today").strftime('%Y-%m-%d') for _ in range(num_records)],
        'claim_amount': [round(random.uniform(200, 20000), 2) for _ in range(num_records)],
        'claim_type': [random.choice(['Theft', 'Accident', 'Natural Disaster', 'Fire', 'Other']) for _ in range(num_records)],
        'claim_status': [random.choice(['Submitted', 'In Review', 'Approved', 'Denied']) for _ in range(num_records)],
    }

    df_claims = pd.DataFrame(data_claims)
    df_claims.to_csv('raw_claims.csv', index=False)


raw_policy()
raw_claims()