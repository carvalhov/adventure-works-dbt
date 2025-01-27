with
    source_staging as (
        select *
        from {{ ref('stg_sales__salesterritory') }}
    )

    , dim_country as (
        select *
        from {{ ref('dim_country') }}
    )

    , dim_territory as (
        select
            source_staging.pk_territory
            , source_staging.territory_name
            , dim_country.pk_country_region as fk_country_region
            , source_staging.territory_group
            , source_staging.sales_ytd
            , source_staging.sales_last_year
            , source_staging.cost_ytd
            , source_staging.cost_last_year
            , source_staging.row_guid
            , source_staging.dt_modified_at
        from source_staging
        left join dim_country
            on source_staging.fk_country_region_code = dim_country.pk_country_region
        qualify row_number() over (
            partition by source_staging.pk_territory
            order by source_staging.dt_modified_at desc
        ) = 1
    )

select *
from dim_territory