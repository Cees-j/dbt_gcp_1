with dim_policy as (
    select
        policy_id,
        policyholder_id,
        policy_type,
        start_date,
        end_date,
        premium

    from {{ ref('stg_policy') }}

)

select
    *
from dim_policy