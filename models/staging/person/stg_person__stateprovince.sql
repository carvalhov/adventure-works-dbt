with
    sources as (
        select *
        from {{ source('person', 'stateprovince') }}
    )
    , casting as (
        select
            cast(StateProvinceID as integer) as pk_state_province
            , cast(StateProvinceCode as string) as state_province_code
            , cast(CountryRegionCode as string) as fk_country_region
            , cast(IsOnlyStateProvinceFlag as boolean) as is_only_state_province
            , cast(Name as string) as state_province_name
            , cast(TerritoryID as integer) as fk_sales_territory
            , cast(rowguid as string) as row_guid
            , cast(ModifiedDate as date) as dt_modified_at
            , cast(_SDC_EXTRACTED_AT as timestamp) as dt_extracted_at
        from sources
    )
select *
from casting