with
    int_customers as (
        select *
        from {{ ref('int_customers_info') }}
    )

    , marts as (
        select
            pk_customer_id
            , fk_person_id
            , fk_store_id
            , fk_territory_id
            , fk_sales_person_id
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