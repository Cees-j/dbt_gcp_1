SELECT *
FROM {{ source('raw_data', 'raw_policies') }}
WHERE policy_type IN ('Auto', 'Home', 'Life', 'Health', 'Travel')