with

    source as (select * from {{ ref("heatpump_compressor_starts_daily") }}),

    monthly_values as (
        select
            date_trunc('month', day) as month,
            sum(compressor_starts_heating)::int as compressor_starts_heating,
            sum(compressor_starts_water)::int as compressor_starts_water
        from source
        group by date_trunc('month', day)
        order by month desc
    )

select *
from monthly_values
