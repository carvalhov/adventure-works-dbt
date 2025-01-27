with
    source_staging as (
        select *
        from {{ ref('stg_person__countryregion') }}
    )

    , dim_country as (
        select
            pk_country_region
            , contry_region_name
            , dt_modified_at
            , dt_extracted_at
        from source_staging
    )

select *
from dim_country