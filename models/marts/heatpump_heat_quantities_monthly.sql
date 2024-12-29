with

source as (

    select * from {{ ref('heatpump_heat_quantities') }}

),

monthly_values as
    (
    select 
        date_trunc('month', created_date) as month,
        max(heat_quantity_heating) - min(heat_quantity_heating) as heat_quantity_heating,
        max(heat_quantity_water) - min(heat_quantity_water) as heat_quantity_water
    from source
    where heat_quantity_heating > 0 and heat_quantity_water > 0
    group by date_trunc('month', created_date)
    order by month desc
)

select * from monthly_values


