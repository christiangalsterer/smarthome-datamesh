with

source as (

    select * from {{ ref('meter_heat_quantities') }}

),

monthly_values as
    (
    select 
        date_trunc('month', created_date) as month,
        max(heat_quantity) - min(heat_quantity) as heat_quantity,
    from source
    where heat_quantity
    group by date_trunc('month', created_date)
    order by month desc
)

select * from monthly_values


