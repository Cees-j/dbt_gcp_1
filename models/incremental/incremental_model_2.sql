{{
    config(
        materialized='incremental',
        unique_key='task_id' 
    )
}}



select task_id,
       task_name,
       updated_at,
       '{{ invocation_id }}' as batch_id
       FROM {{ source('raw_data', 'raw_incremental') }}



{% if is_incremental() %}


where
  updated_at > (select max(updated_at) from {{ this }})

{% endif %}