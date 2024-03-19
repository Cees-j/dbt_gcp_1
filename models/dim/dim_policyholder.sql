with dim_policyholder as (
    select
        policyholder_id,
        first_name,
        last_name,
        birthdate,
        city,
        state,
        cleaned_zip_code

    from {{ ref('stg_policyholder') }}
    
)

select
    *
from dim_policyholder