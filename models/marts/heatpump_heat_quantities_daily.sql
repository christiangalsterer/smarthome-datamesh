with

source as (

    select * from {{ ref('heatpump_heat_quantities') }}

),

daily_values as
    (
    select 
        date_trunc('day', created_date) as day,
        max(heat_quantity_heating) - min(heat_quantity_heating) as heat_quantity_heating,
        max(heat_quantity_water) - min(heat_quantity_water) as heat_quantity_water
    from source
    group by date_trunc('day', created_date)
    HAVING (min(heat_quantity_heating) > 0 AND min(heat_quantity_water) > 0)
    order by day desc
)

select * from daily_values


