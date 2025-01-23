with

source as (

    select * from {{ ref('heatpump_heat_quantities') }}

),

yearly_values as
    (
    select 
        date_trunc('year', created_date) as year,
        max(heat_quantity_heating) - min(heat_quantity_heating) as heat_quantity_heating,
        max(heat_quantity_water) - min(heat_quantity_water) as heat_quantity_water
    from source
    where heat_quantity_heating > 0 and heat_quantity_water > 0
    group by date_trunc('year', created_date)
    order by year desc
)

select * from yearly_values
