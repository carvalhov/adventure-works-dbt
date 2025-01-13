with
    sources as (
        select *
        from {{ source('production', 'product') }}
    )

    , casting as (
        select
            cast(ProductID as int) as pk_product_id
            , cast(ProductSubcategoryID as int) as fk_product_subcategory_id
            , cast(ProductModelID as int) as fk_product_model_id
            , cast(SellStartDate as date) as sell_start_date
            , cast(SellEndDate as date) as sell_end_date
            , cast(Name as string) as product_name
            , cast(ProductNumber as string) as product_number
            , cast(MakeFlag as boolean) as is_manufactured
            , cast(FinishedGoodsFlag as boolean) as is_salable
            , cast(Color as string) as product_color
            , cast(SafetyStockLevel as smallint) as safety_stock_level
            , cast(ReorderPoint as smallint) as reorder_point
            , cast(StandardCost as decimal(19, 4)) as standard_cost
            , cast(ListPrice as decimal(19, 4)) as list_price
            , cast(Size as string) as product_size
            , cast(SizeUnitMeasureCode as string) as size_unit_measure_code
            , cast(WeightUnitMeasureCode as string) as weight_unit_measure_code
            , cast(Weight as decimal(8, 2)) as weight
            , cast(DaysToManufacture as int) as days_to_manufacture
            , case
                when ProductLine = 'R' then 'Road'
                when ProductLine = 'M' then 'Mountain'
                when ProductLine = 'T' then 'Touring'
                when ProductLine = 'S' then 'Standard'
                else ProductLine
            end as product_line_description
            , case
                when Class = 'H' then 'High'
                when Class = 'M' then 'Medium'
                when Class = 'L' then 'Low'
                else Class
            end as product_class_description
            , case
                when Style = 'W' then 'Womens'
                when Style = 'M' then 'Mens'
                when Style = 'U' then 'Universal'
                else Style
            end as product_style_description
            , cast(DiscontinuedDate as date) as discontinued_date
            , cast(rowguid as string) as row_guid
            , cast(ModifiedDate as date) as dt_modified_at
        from sources
    )

select *
from casting

