with
    stg_products as (
        select *
        from {{ ref('stg_production__products') }}
    )

select *
from stg_products