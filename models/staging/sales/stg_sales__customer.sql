with
    sources as (
        select *
        from {{ source('sales', 'customer') }}
    )

    , casting as (
        select
            cast(CustomerID as int) as pk_customer_id
            , cast(PersonID as int) as fk_person_id
            , cast(StoreID as int) as fk_store_id
            , cast(TerritoryID as int) as fk_territory_id
            , cast(rowguid as string) as row_guid
            , cast(ModifiedDate as date) as dt_modified_at
        from sources
    )

select *
from casting
