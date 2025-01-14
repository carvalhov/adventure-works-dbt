with
    source_intermediate as (
        select *
        from {{ ref('int_sales_orders_add_info') }}
    )

    , dim_sales_order_reason as (
        select
            pk_sales_order
            , fk_sales_reason
            , sales_reason_name
            , sales_reason_type
            , dt_modified_at
            , dt_extracted_at
        from source_intermediate
    )

select *
from dim_sales_order_reason
