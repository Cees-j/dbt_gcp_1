{{
    config(
        materialized='incremental',
        unique_key='task_id' 
    )
}}

select * FROM {{ source('raw_data', 'raw_incremental') }}



{% if is_incremental() %}


where
  updated_at > (select max(updated_at) from {{ this }})

{% endif %}