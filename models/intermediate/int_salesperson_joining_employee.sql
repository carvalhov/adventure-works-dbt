with
    source_salesperson as (
        select *
        from {{ ref('stg_sales__salesperson') }}
    )

    , source_employee as (
        select *
        from {{ ref('stg_humanresources__employee') }}
    )

    , joining_salesperson_employee as (
        select
            source_salesperson.pk_salesperson
            , source_salesperson.territory_id
            , source_employee.national_id_number
            , source_employee.hire_date
            , source_employee.birth_date
            , source_employee.organization_node
            , source_employee.organization_level
            , source_employee.job_title
            , source_employee.gender
            , source_employee.vacation_hours
            , source_employee.is_salaried
            , source_employee.sick_leave_hours
            , source_employee.is_active
            , source_salesperson.vl_sales_quota
            , source_salesperson.vl_bonus
            , source_salesperson.vl_comission_percent
            , source_salesperson.vl_total_sales_ytd
            , source_salesperson.vl_sales_last_year
            , source_salesperson.row_guid
            , source_salesperson.dt_modified_at
            , source_salesperson.dt_extracted_at
        from source_salesperson
        left join source_employee
            on source_salesperson.pk_salesperson = source_employee.pk_employee
    )

select *
from joining_salesperson_employee
