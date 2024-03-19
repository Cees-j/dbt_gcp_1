{% macro alter_claim_type() %}
    CASE
        WHEN RAND() < 1.0/3 THEN 'Auto'
        WHEN RAND() < 2.0/3 THEN 'Pet'
        ELSE 'Home'
    END
{% endmacro %}
