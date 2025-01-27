with
    source_staging as (
        select *
        from {{ ref('stg_sales__salesterritory') }}
    )

select *
from source_staging