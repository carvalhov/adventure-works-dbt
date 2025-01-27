with
    int_customers as (
        select *
        from {{ ref('int_customers_info') }}
    )

    , marts as (
        select
            pk_customer_id as pk_customer
            , fk_person_id as fk_person
            , fk_store_id as fk_store
            , fk_territory_id as fk_territory
            , fk_sales_person_id as fk_salesperson
            , dt_modified_at
            , person_type
            , person_name
            , email_promotion
            , store_name
            , territory_name
            , territory_group
        from int_customers
    )

select *
from marts