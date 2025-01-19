with
    sources as (
        select *
        from {{ source('humanresources', 'employee') }}
    )

    , casting as (
        select
            cast(BusinessEntityID as int) as pk_employee
            , cast(NationalIDNumber as string) as national_id_number
            , cast(LoginID as string) as login_id
            , cast(OrganizationNode as string) as organization_node
            , len(organization_node) - len(replace(organization_node, '/', '')) as organization_level
            , cast(JobTitle as string) as job_title
            , cast(BirthDate as date) as birth_date
            , case
                when MaritalStatus = 'M' then 'Married'
                when MaritalStatus = 'S' then 'Single'
                else MaritalStatus
            end as marital_status
            , case
                when Gender = 'M' then 'Male'
                when Gender = 'F' then 'Female'
            end as gender
            , cast(HireDate as date) as hire_date
            , cast(SalariedFlag as boolean) as is_salaried
            , cast(VacationHours as smallint) as vacation_hours
            , cast(SickLeaveHours as smallint) as sick_leave_hours
            , cast(CurrentFlag as boolean) as is_active
            , cast(rowguid as string) as row_guid
            , cast(ModifiedDate as date) as dt_modified_at
            , cast(_SDC_EXTRACTED_AT as timestamp) as dt_extracted_at
        from sources
    )

select *
from casting
