with
    sources as (
       select *
        from {{ source('sales', 'salesorderheader') }}
    )
    , casting as (
        select
            cast(SalesOrderID as integer) as pk_sales_order
            , cast(CustomerID as integer) as fk_customer
            , coalesce(cast(SalesPersonID as integer), 0) as fk_salesperson
            , cast(TerritoryID as integer) as fk_sales_territory
            , cast(BillToAddressID as integer) as fk_bill_to_address
            , cast(ShipToAddressID as integer) as fk_ship_to_address
            , cast(ShipMethodID as integer) as fk_ship_method
            , cast(CreditCardID as integer) as fk_credit_card
            , cast(CurrencyRateID as integer) as fk_currency_rate
            , cast(OrderDate as date) as dt_order
            , cast(DueDate as date) as dt_due
            , cast(ShipDate as date) as dt_ship
            , cast(ModifiedDate as date) as dt_modified_at
            , cast(RevisionNumber as integer) as revision_number
            , cast(Status as integer) as order_status
            , cast(OnlineOrderFlag as boolean) as is_online_order
            , cast(PurchaseOrderNumber as string) as purchase_order_number
            , cast(AccountNumber as string) as account_number
            , cast(CreditCardApprovalCode as string) as credit_card_approval_code
            , cast(SubTotal as numeric) as subtotal
            , cast(TaxAmt as numeric) as tax_amount
            , cast(Freight as numeric) as freight
            , cast(TotalDue as numeric) as total_due
            , cast(Comment as string) as sales_comment
            , cast(rowguid as string) as row_guid
            , cast(_SDC_EXTRACTED_AT as timestamp) as dt_extracted_at
        from sources
    )
select *
from casting