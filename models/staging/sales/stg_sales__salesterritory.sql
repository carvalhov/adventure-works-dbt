with
    sources as (
        select *
        from {{ source('sales', 'salesterritory') }}
    )

    , casting as (
        select
            cast(TerritoryID as int) as pk_territory
            , cast(Name as string) as territory_name
            , cast(CountryRegionCode as string) as fk_country_region_code
            , cast("GROUP" as string) as territory_group
            , cast(SalesYTD as float) as sales_ytd
            , cast(SalesLastYear as float) as sales_last_year
            , cast(CostYTD as float) as cost_ytd
            , cast(CostLastYear as float) as cost_last_year
            , cast(rowguid as string) as row_guid
            , cast(ModifiedDate as date) as dt_modified_at
        from sources
    )

select *
from casting
