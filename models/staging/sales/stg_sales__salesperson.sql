with
    sources as (
        select *
        from {{ source('sales', 'salesperson') }}
    )

    , casting as (
        select
            cast(businessentityid as int) as pk_salesperson
            , cast(territoryid as int) as territory_id
            , cast(salesquota as float) as vl_sales_quota
            , cast(bonus as float) as vl_bonus
            , cast(commissionpct as float) as vl_comission_percent
            , cast(salesytd as float) as vl_total_sales_ytd
            , cast(saleslastyear as float) as vl_sales_last_year
            , cast(rowguid as string) as row_guid
            , cast(ModifiedDate as date) as dt_modified_at
            , cast(_SDC_EXTRACTED_AT as timestamp) as dt_extracted_at
        from sources
    )

select *
from casting