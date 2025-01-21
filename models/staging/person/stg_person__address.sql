with
    sources as (
        select *
        from {{ source('person', 'address') }}
    )
    , casting as (
        select
            cast(AddressID as integer) as pk_address
            , cast(AddressLine1 as string) as address_line_1
            , cast(AddressLine2 as string) as address_line_2
            , cast(City as string) as city_name
            , cast(StateProvinceID as integer) as fk_state_province
            , cast(PostalCode as string) as postal_code
            , cast(SpatialLocation as string) as spatial_location
            , cast(rowguid as string) as row_guid
            , cast(ModifiedDate as date) as dt_modified_at
            , cast(_SDC_EXTRACTED_AT as timestamp) as dt_extracted_at
        from sources
    )
select *
from casting