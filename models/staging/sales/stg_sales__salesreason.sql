with
    sources as (
        select *
        from {{ source('sales', 'salesreason') }}
    )

    , casting as (
        select
            cast(salesreasonid as int) as pk_sales_reason
            , cast(name as string) as sales_reason_name
            , cast(ReasonType as string) as sales_reason_type
            , cast(modifieddate as timestamp) as dt_motified_at
        from sources
    )

select *
from casting

