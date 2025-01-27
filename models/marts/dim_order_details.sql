with
    sales_order_detail as (
        select *
        from {{ ref('stg_sales__salesorderdetail') }}
    )

    , dim_product as (
        select *
        from {{ ref('dim_product') }}
    )

    , joining_products as (
        select
            sales_order_detail.pk_sales_order_detail
            , dim_product.pk_product as fk_product
            , sales_order_detail.fk_sales_order
            , dim_product.product_name
            , dim_product.sell_start_date
            , dim_product.sell_end_date
            , dim_product.safety_stock_level
            , dim_product.standard_cost
            , dim_product.list_price
            , dim_product.days_to_manufacture
            , sales_order_detail.order_quantity
            , sales_order_detail.unit_price
            , sales_order_detail.unit_price_discount
            , sales_order_detail.order_total_price
            , sales_order_detail.dt_extracted_at
        from sales_order_detail
        left join dim_product
            on sales_order_detail.fk_product = dim_product.pk_product
    )

select *
from joining_products
