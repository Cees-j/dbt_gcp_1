WITH stg_claims AS (
    SELECT *
    FROM {{ ref('stg_claims') }}
)

SELECT
    stg_claims.*,
    seed.claim_code as claim_code
FROM stg_claims 

LEFT JOIN {{ ref('claim_codes') }} seed ON stg_claims.claim_status = seed.claim_status
