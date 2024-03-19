WITH raw_claims AS (
    SELECT *
    FROM {{ source('raw_data', 'raw_claims') }}
),

changed_claim_type as (
    SELECT 
        claim_id,
        policy_id,
        date_of_claim,
        claim_amount,
        {{ alter_claim_type() }} AS policy_type,
        -- using a macro to change claim_types to policy types
        -- so can join on another field if needed
        claim_type,
        claim_status
    FROM raw_claims
)

SELECT * 
FROM changed_claim_type