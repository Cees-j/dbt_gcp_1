WITH raw_policyholders AS (
    SELECT *
    FROM {{ source('raw_data', 'raw_policyholders') }}
),

valid_birthdates AS (
    SELECT *
    FROM raw_policyholders
    WHERE birthdate < CURRENT_DATE
),

non_null_first_names AS (
    SELECT *
    FROM valid_birthdates
    WHERE first_name IS NOT NULL
),

address_parts AS (
    SELECT
    policyholder_id,
    first_name,
    last_name,
    birthdate,
    address,
    SPLIT(address, ' ')[SAFE_OFFSET(0)] as street_number,
    SPLIT(address, ' ')[SAFE_OFFSET(1)] as street_name,
    SPLIT(address, ' ')[SAFE_OFFSET(2)] as city,
    SPLIT(address, ' ')[SAFE_OFFSET(3)] as state,
    SPLIT(address, ' ')[SAFE_OFFSET(4)] as zip_code
    FROM non_null_first_names
),

numerical_zip_code AS (
    SELECT
        policyholder_id,
        first_name,
        last_name,
        birthdate,
        address,
        street_number,
        street_name,
        city,
        state,
        zip_code AS original_zip_code, 
        SAFE_CAST(REGEXP_REPLACE(zip_code, ',', '') AS INT64) AS cleaned_zip_code 
    FROM address_parts
    WHERE SAFE_CAST(REGEXP_REPLACE(zip_code, ',', '') AS INT64) IS NOT NULL
)


SELECT *
FROM numerical_zip_code