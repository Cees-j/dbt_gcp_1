Incremental models allow you to create models that dont need to be loaded fully every time
Can set a HWM and then only load up to that 

{{
    config(
        materialized='incremental',         # Can set materizalisation here or in properties as normal
        unique_key='task_id'                # This allows merging rather than appending and ending up with duplicates.
    )                                       # Is the only option that bq supports
}}



select task_id,
       task_name,
       updated_at,
       '{{ invocation_id }}' as batch_id                 # Jinja macro to add a UUID to each run
       FROM {{ source('raw_data', 'raw_incremental') }}



{% if is_incremental() %}              # Jinja macro checking a number of conditions, such as does the table already exist
                                       # if that passes then continues on with the where clause deciding what data to bring through

where
  updated_at > (select max(updated_at) from {{ this }})

{% endif %}