with claims as (
    select
        claim_id,
        claim_amount,
        claim_status,
        claim_type,
        claim_code,
        policy_id,           -- Needed for joining with policy_dimension
    from {{ ref('stg_claims_2') }}
),

policy_dimension as (
    select
        policy_id,
        policyholder_id
        -- Other attributes you need from policy_dimension, excluding policy_id in the final select
    from {{ ref('dim_policy') }}
),

policyholder_dimension as (
    select
        policyholder_id,
        -- Other attributes you need from policyholder_dimension, excluding policyholder_id in the final select
    from {{ ref('dim_policyholder') }}
)

select
    c.claim_id,
    c.claim_amount,
    c.claim_status,
    c.claim_type,
    c.claim_code,
    p.policy_id as policy_key,      -- Derived from policy_dimension, for clarity
    ph.policyholder_id as policyholder_key  -- Derived from policyholder_dimension, for clarity
from claims c
left join policy_dimension p on c.policy_id = p.policy_id
left join policyholder_dimension ph on p.policyholder_id = ph.policyholder_id


