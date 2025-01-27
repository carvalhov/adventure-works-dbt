with
    staging_sales_reason as (
        select *
        from {{ ref('stg_sales__salesreason') }}
    )

    , staging_sales_order_header_sales_reason as (
        select *
        from {{ ref('stg_sales__salesorderheadersalesreason') }}
    )

    , joining as (
        select
            sales_order.pk_sales_order as pk_sales_order
            , sales_reason.pk_sales_reason as fk_sales_reason
            , case
                when sales_reason.pk_sales_reason is not null
                    then sales_reason.sales_reason_name
                when sales_reason.pk_sales_reason is not null
                    then 'Other'
            end as sales_reason_name
            , sales_reason.sales_reason_type
            , sales_order.dt_modified_at
            , sales_order.dt_extracted_at
        from staging_sales_order_header_sales_reason as sales_order
        left join staging_sales_reason as sales_reason
            on sales_order.fk_sales_reason = sales_reason.pk_sales_reason
    )

select *
from joining
