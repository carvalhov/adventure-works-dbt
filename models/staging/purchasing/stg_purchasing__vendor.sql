with
    sources as (
        select *
        from {{ source('purchasing', 'vendor')}}
    )

    , casting as (
        select
            cast(BUSINESSENTITYID as int) as pk_business_entity
            , cast(ACCOUNTNUMBER as string) as account_number
            , cast(ACTIVEFLAG as boolean) as is_active
            , cast(CREDITRATING as int) as credit_rating
            , cast(NAME as string) as company_name
            , cast(PREFERREDVENDORSTATUS as string) as vendor_status
            , cast(MODIFIEDDATE as date) as dt_modified_at
            , cast(PURCHASINGWEBSERVICEURL as string) as purchasing_web_service_url
        from sources
    )

select *
from casting
