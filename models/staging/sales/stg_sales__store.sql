with
    sources as (
        select *
        from {{ source('sales', 'store') }}
    )

    , casting as (
        select
            cast(BusinessEntityID as int) as pk_store_business_entity
            , cast(Name as string) as store_name
            , cast(SalesPersonID as int) as fk_sales_person_id
            , cast(Demographics as string) as demographics
            , cast(rowguid as string) as row_guid
            , cast(ModifiedDate as date) as dt_modified_at
        from sources
    )

select *
from casting