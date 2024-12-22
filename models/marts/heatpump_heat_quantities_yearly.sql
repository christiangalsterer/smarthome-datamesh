with

source as (

    select * from {{ ref('heatpump_heat_quantities_monthly') }}

),

yearly_values as
    (
    select 
        date_trunc('year', month) as year,
        sum(heat_quantity_heating) as heat_quantity_heating,
        sum(heat_quantity_water) as heat_quantity_water
    from source
    group by date_trunc('year', month)
    order by year desc
)

select * from yearly_values

