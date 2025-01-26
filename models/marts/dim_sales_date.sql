with
    dim_sales_date as (
        select *
        from {{ ref('stg_sales__salesorderheader') }}
    )

select *
from dim_sales_date

