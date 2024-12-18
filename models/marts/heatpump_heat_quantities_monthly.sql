with

source as (

    select * from {{ ref('heatpump_heat_quantities_daily') }}

),

monthly_values as
    (

    select 
        date_trunc('month', day) as month,
        sum(heat_quantity_heating) as heat_quantity_heating,
        sum(heat_quantity_water) as heat_quantity_water
    from source
    group by date_trunc('month', day)
    order by month desc
)

select * from monthly_values


