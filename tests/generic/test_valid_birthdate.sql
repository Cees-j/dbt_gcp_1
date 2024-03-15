-- test is called valid_birthdate
-- it takes a model a column_name as defined in the test.yml
-- uses jinja to pass variables 
-- its looking for if the birthdate is more than the current date-
-- if no rows are returned, test is passed


{% test valid_birthdate(model, column_name) %}

with validation as (

    select
        {{ column_name }} as valid_birthdate

    from {{ model }}

),

validation_errors as (

    select
        *
    from {{ model }}
    where {{ column_name }} > CURRENT_DATE

)

select *
from validation_errors

{% endtest %}