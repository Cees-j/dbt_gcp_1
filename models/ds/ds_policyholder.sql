{{ config(materialized='table') }} -- can either specify here or in models / folder in dbt_project.yml


SELECT * FROM {{ source('raw_data', 'raw_policyholders') }}