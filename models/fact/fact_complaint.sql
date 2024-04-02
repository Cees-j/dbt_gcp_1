with stg_complaints as (
    select 
        complaint_id,
        policyholder_id,
        status
    from {{ ref("stg_complaints")}}
),

policyholder_dimension as (
    select
        policyholder_id,   
    from {{ ref('dim_policyholder') }}
)


select
    md5(complaint_id || status) as surrogate_key,
    complaint_id,
    status,
    ph.policyholder_id
    from stg_complaints stg_c
    left join policyholder_dimension ph on ph.policyholder_id = stg_c.policyholder_id

