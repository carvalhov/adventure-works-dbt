with
    sources as (
        select *
        from {{ source( 'person' , 'countryregion') }}
    )

    , casting as (
        select
            cast(CountryRegionCode as string) as pk_country_region
            , cast(name as string) as contry_region_name
            , cast(ModifiedDate as date) as dt_modified_at
            , cast(_SDC_EXTRACTED_AT as timestamp) as dt_extracted_at
        from sources
    )

select *
from casting