with

source as (

    select * from {{ ref('heatpump_compressor_starts_daily') }}

),

monthly_values as
    (
    select 
        date_trunc('month', day) as month,
        sum(compressor_heating_starts)::int as compressor_heating_starts,
        sum(compressor_water_starts)::int as compressor_water_starts
    from source
    group by date_trunc('month', day)
    order by month desc
)

select * from monthly_values