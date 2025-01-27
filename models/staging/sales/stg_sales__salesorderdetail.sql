with
    sources as (
        select *
        from {{ source('sales', 'salesorderdetail') }}
    )

    , transforming as (
        select
            cast(SalesOrderDetailID as integer) as pk_sales_order_detail
            , cast(SalesOrderID as integer) as fk_sales_order
            , cast(ProductID as integer) as fk_product
            , cast(SpecialOfferID as integer) as fk_special_offer
            , cast(ModifiedDate as date) as dt_modified_at
            , cast(CarrierTrackingNumber as string) as carrier_tracking_number
            , cast(OrderQty as integer) as order_quantity
            , cast(UnitPrice as numeric) as unit_price
            , cast(UnitPriceDiscount as numeric) as unit_price_discount
            , ((OrderQty*UnitPrice)*(1-UnitPriceDiscount)) as order_total_price
            , cast(rowguid as string) as row_guid
            , cast(_SDC_EXTRACTED_AT as timestamp) as dt_extracted_at
        from sources
    )

select *
from transforming