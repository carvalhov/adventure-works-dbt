with
    sources as (
        select *
        from {{ source('person', 'person') }}
    )

    , transforming as (
        select
            cast(BusinessEntityID as int) as pk_person_business_entity
            , case
                when PersonType = 'SC' then 'Store Contact'
                when PersonType = 'IN' then 'Individual (retail) customer'
                when PersonType = 'SP' then 'Sales person'
                when PersonType = 'EM' then 'Employee (non-sales)'
                when PersonType = 'VC' then 'Vendor contact'
                when PersonType = 'GC' then 'General contact'
            end as person_type
            , cast(NameStyle as boolean) as is_name_style
            , cast(Title as string) as title
            , cast(FirstName as string) as first_name
            , cast(MiddleName as string) as middle_name
            , cast(LastName as string) as last_name
            , case
                when is_name_style = 0 then
                    concat_ws(' ', coalesce(title, ''), coalesce(first_name, ''), coalesce(middle_name, ''), coalesce(last_name, ''), coalesce(suffix, ''))
                when is_name_style = 1 then
                    concat_ws(' ', coalesce(title, ''), coalesce(last_name, ''), coalesce(first_name, ''), coalesce(middle_name, ''), coalesce(suffix, ''))
            end as person_name
            , cast(Suffix as string) as suffix
            , cast(EmailPromotion as int) as email_promotion
            , cast(AdditionalContactInfo as string) as additional_contact_info
            , cast(Demographics as string) as demographics
            , cast(rowguid as string) as row_guid
            , cast(ModifiedDate as date) as dt_modified_at
        from sources
    )

select *
from transforming
