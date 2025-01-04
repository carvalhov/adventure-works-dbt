with
    int_customers as (
        select *
        from {{ ref('int_customers_info') }}
    )

select *
from int_customers