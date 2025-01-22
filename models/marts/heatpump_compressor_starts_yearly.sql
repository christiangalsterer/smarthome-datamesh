with

source as (

    select * from {{ ref('heatpump_compressor_starts_monthly') }}

),

yearly_values as
    (
    select 
        date_trunc('year', month) as year,
        sum(compressor_heating_starts)::int as compressor_heating_starts,
        sum(compressor_water_starts)::int as compressor_water_starts
    from source
    group by date_trunc('year', month)
    order by year desc
)

select * from yearly_values