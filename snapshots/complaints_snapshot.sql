{% snapshot complaints_snapshot %}

    {{
        config(
          target_schema='snapshots',
          strategy='timestamp',
          unique_key='complaint_id',
          updated_at='updated_at'
        )
    }}

    select * from {{ source('raw_data', 'raw_complaints') }}

{% endsnapshot %}