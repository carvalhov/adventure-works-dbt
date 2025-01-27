with
    stg_salesorderheader as (
        select *
        from {{ ref('stg_sales__salesorderheader') }}
    )

    , dim_customer as (
        select *
        from {{ ref('dim_customer') }}
    )

    , dim_order_details as (
        select *
        from {{ ref('dim_order_details') }}
    )

    , dim_salesperson as (
        select *
        from {{ ref('dim_salesperson') }}
    )

    , dim_territory as (
        select *
        from {{ ref('dim_territory') }}
    )

    , dim_city as (
        select *
        from {{ ref('dim_city') }}
    )

    , dim_sales_reason as (
        select *
        from {{ ref('dim_sales_order_reason') }}
    )

    , joining as (
        select
            stg_salesorderheader.pk_sales_order
            , dim_customer.pk_customer as fk_customer
            , coalesce(dim_salesperson.pk_salesperson, stg_salesorderheader.fk_salesperson) as fk_salesperson
            , dim_order_details.fk_product
            , coalesce(dim_sales_reason.fk_sales_reason, 0) as fk_sales_reason
            , dim_territory.pk_territory as fk_territory
            , dim_territory.fk_country_region
            , bill_to_city.pk_address as fk_bill_to_city
            , ship_to_city.pk_address as fk_ship_to_city
            , dim_dates.date_day as dt_order
            , stg_salesorderheader.dt_due
            , stg_salesorderheader.dt_ship
            , stg_salesorderheader.dt_modified_at
            , dim_territory.territory_name
            , stg_salesorderheader.revision_number
            , stg_salesorderheader.order_status
            , stg_salesorderheader.is_online_order
            , stg_salesorderheader.purchase_order_number
            , stg_salesorderheader.account_number
            , stg_salesorderheader.credit_card_approval_code
            , case
                when stg_salesorderheader.credit_card_approval_code is null
                    then 'Others'
                when stg_salesorderheader.credit_card_approval_code is not null
                    then  'Credit Card'
            end as payment_type
            , stg_salesorderheader.subtotal
            , stg_salesorderheader.tax_amount
            , stg_salesorderheader.freight
            , stg_salesorderheader.total_due
            , stg_salesorderheader.sales_comment
            , stg_salesorderheader.dt_extracted_at
        from stg_salesorderheader
        left join dim_customer
            on stg_salesorderheader.fk_customer = dim_customer.pk_customer
        left join dim_order_details
            on stg_salesorderheader.pk_sales_order = dim_order_details.fk_sales_order
        left join dim_salesperson
            on stg_salesorderheader.fk_salesperson = dim_salesperson.pk_salesperson
        left join dim_territory
            on stg_salesorderheader.fk_sales_territory = dim_territory.pk_territory
        left join dim_city as bill_to_city
            on stg_salesorderheader.fk_bill_to_address = bill_to_city.pk_address
        left join dim_city as ship_to_city
            on stg_salesorderheader.fk_ship_to_address = ship_to_city.pk_address
        left join dim_sales_reason
            on stg_salesorderheader.pk_sales_order = dim_sales_reason.pk_sales_order
        left join dim_dates
            on stg_salesorderheader.dt_order = dim_dates.date_day
        qualify row_number() over (
            partition by stg_salesorderheader.pk_sales_order
            order by stg_salesorderheader.dt_extracted_at desc
        ) = 1
    )

select *
from joining

