with
    source_staging as (
        select *
        from {{ ref('stg_person__stateprovince') }}
    )

select *
from source_staging
