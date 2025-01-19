with
    source_intermediate as (
        select *
        from {{ ref('int_salesperson_joining_employee') }}
    )

select *
from source_intermediate
