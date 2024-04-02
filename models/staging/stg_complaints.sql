WITH stg_complaints_ss AS (
    SELECT *
    FROM {{ ref('complaints_snapshot') }}
)

SELECT * 
FROM  stg_complaints_ss
WHERE dbt_valid_to IS NULL
    
