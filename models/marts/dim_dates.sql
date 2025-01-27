with
    dates_raw as (
    {{ dbt_utils.date_spine(
        datepart="day",
        start_date="cast('2010-01-01' as date)",
        end_date="dateadd(year, 20, current_date())"
        )
    }}
)
    , days_info as (
        select
            cast(date_day as date) as date_day
            , dayofweek(date_day) as day_of_week
            , month(date_day) as month
            , quarter(date_day) as quarter
            , dayofyear(date_day) as day_of_year
            , year(date_day) as year
            , monthname(date_day) as month_name_long
            , to_varchar(date_day, 'DD-MM') as day_month
        from dates_raw
    )
    , days_named as (
        select
            *
            , case
                when day_of_week = 1 then 'Sunday'
                when day_of_week = 2 then 'Monday'
                when day_of_week = 3 then 'Tuesday'
                when day_of_week = 4 then 'Wednesday'
                when day_of_week = 5 then 'Thursday'
                when day_of_week = 6 then 'Friday'
                else 'Saturday'
            end as day_name
            , case
                when month = 1 then 'January'
                when month = 2 then 'February'
                when month = 3 then 'March'
                when month = 4 then 'April'
                when month = 5 then 'May'
                when month = 6 then 'June'
                when month = 7 then 'July'
                when month = 8 then 'August'
                when month = 9 then 'September'
                when month = 10 then 'October'
                when month = 11 then 'November'
                else 'December'
            end as month_name
            , case
                when month = 1 then 'Jan'
                when month = 2 then 'Feb'
                when month = 3 then 'Mar'
                when month = 4 then 'Apr'
                when month = 5 then 'May'
                when month = 6 then 'Jun'
                when month = 7 then 'Jul'
                when month = 8 then 'Aug'
                when month = 9 then 'Sep'
                when month = 10 then 'Oct'
                when month = 11 then 'Nov'
                else 'Dec'
            end as month_abbrev
            , case
                when quarter = 1 then '1st Quarter'
                when quarter = 2 then '2nd Quarter'
                when quarter = 3 then '3rd Quarter'
                else '4th Quarter'
            end as quarter_name
            , case
                when quarter in(1,2) then 1
                else 2
            end as semester
            , case
                when quarter in(1,2) then '1st Semester'
                else '2nd Semester'
            end as semester_name
        from days_info
    )
    , final_cte as (
        select
            date_day
            , day_of_week
            , day_name
            , month
            , month_name_long
            , month_name
            , month_abbrev
            , quarter
            , quarter_name
            , semester
            , semester_name
            , day_of_year
            , year
        from days_named
    )
select * from final_cte