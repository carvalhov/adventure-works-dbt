with
    sources as (
        select *
        from {{ source('sales', 'salesorderheadersalesreason') }}
    )

    , casting as (
        select
            cast(salesorderid as int) as pk_sales_order
            , cast(salesreasonid as int) as fk_sales_reason
            , cast(modifieddate as timestamp) as dt_modified_at
            , cast(_SDC_EXTRACTED_AT as timestamp) as dt_extracted_at
        from sources
        qualify row_number() over (
            partition by salesorderid
            order by dt_extracted_at desc
        ) = 1
    )

select *
from casting
