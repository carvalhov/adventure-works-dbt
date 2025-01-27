with
    sources as (
        select *
        from {{ source('production', 'product') }}
    )

    , casting as (
        select
            cast(ProductID as int) as pk_product
            , cast(ProductSubcategoryID as int) as fk_product_subcategory
            , cast(ProductModelID as int) as fk_product_model
            , cast(SellStartDate as date) as sell_start_date
            , cast(SellEndDate as date) as sell_end_date
            , cast(Name as string) as product_name
            , cast(ProductNumber as string) as product_number
            , cast(MakeFlag as boolean) as is_manufactured
            , cast(FinishedGoodsFlag as boolean) as is_salable
            , cast(Color as string) as product_color
            , cast(SafetyStockLevel as smallint) as safety_stock_level
            , cast(ReorderPoint as smallint) as reorder_point
            , cast(StandardCost as float) as standard_cost
            , cast(ListPrice as float) as list_price
            , cast(Size as string) as product_size
            , cast(SizeUnitMeasureCode as string) as size_unit_measure_code
            , cast(WeightUnitMeasureCode as string) as weight_unit_measure_code
            , cast(Weight as float) as weight
            , cast(DaysToManufacture as int) as days_to_manufacture
            , case
                when trim(ProductLine) = 'R' then 'Road'
                when trim(ProductLine) = 'M' then 'Mountain'
                when trim(ProductLine) = 'T' then 'Touring'
                when trim(ProductLine) = 'S' then 'Standard'
                when trim(Style) is null then '-'
            end as product_line_description
            , case
                when trim(Class) = 'H' then 'High'
                when trim(Class) = 'M' then 'Medium'
                when trim(Class) = 'L' then 'Low'
                when trim(Style) is null then '-'
            end as product_class_description
            , case
                when trim(Style) = 'W' then 'Womens'
                when trim(Style) = 'M' then 'Mens'
                when trim(Style) = 'U' then 'Universal'
                when trim(Style) is null then '-'
            end as product_style_description
            , cast(DiscontinuedDate as date) as discontinued_date
            , cast(rowguid as string) as row_guid
            , cast(ModifiedDate as date) as dt_modified_at
        from sources
    )

select *
from casting

