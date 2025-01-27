with
    source_customer as (
        select *
        from {{ ref('stg_sales__customer') }}
    )

    , source_person as (
        select *
        from {{ ref('stg_person__person') }}
    )

    , source_store as (
        select *
        from {{ ref('stg_sales__store') }}
    )

    , source_territory as (
        select *
        from {{ ref('stg_sales__salesterritory') }}
    )
    , joining as (
        select
            sc.*
            , sp.person_type
            , sp.person_name
            , sp.email_promotion
            , ss.store_name
            , ss.fk_sales_person_id
            , st.territory_name
            , st.territory_group
        from source_customer as sc
        left join source_person as sp
            on sc.fk_person_id = sp.pk_person_business_entity
        left join source_store as ss
            on sc.fk_store_id = ss.pk_store_business_entity
        left join source_territory as st
            on sc.fk_territory_id = st.pk_territory
    )

select *
from joining
