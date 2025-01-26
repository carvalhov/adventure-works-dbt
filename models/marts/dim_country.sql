with
    source_staging as (
        select *
        from {{ ref('stg_person__countryregion') }}
    )

select *
from source_staging