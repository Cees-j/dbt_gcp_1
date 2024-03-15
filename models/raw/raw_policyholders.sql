{{ config(materialized='table') }}


SELECT * FROM {{ source('raw_data', 'raw_policyholders') }}