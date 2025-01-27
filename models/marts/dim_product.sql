with
    stg_product as (
        select *
        from {{ ref('stg_production__product') }}
    )

select *
from stg_product