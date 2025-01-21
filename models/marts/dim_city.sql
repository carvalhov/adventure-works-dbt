with
    source_staging as(
        select *
        from {{ ref('stg_person__address') }}
    )

select *
from source_staging