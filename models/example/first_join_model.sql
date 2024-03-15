{{ config(materialized='table') }}
{{ config(schema='dbt_cees_stg') }}
-- SELECT *
-- FROM `{{ var('project_name') }}.{{ var('dataset_name') }}.raw_policies` as a
-- JOIN `{{ var('project_name') }}.{{ var('dataset_name') }}.raw_policyholders` as b
-- ON a.policyholder_id = b.policyholder_id


SELECT a.*
FROM `river-pillar-416609.dbt_cees_bq.raw_policies` as a
JOIN `river-pillar-416609.dbt_cees_bq.raw_policyholders` as b
ON a.policyholder_id = b.policyholder_id