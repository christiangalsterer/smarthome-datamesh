with

    source as (select * from {{ ref("heatpump_compressor_starts_monthly") }}),

    yearly_values as (
        select
            date_trunc('year', month) as year,
            sum(compressor_starts_heating)::int as compressor_starts_heating,
            sum(compressor_starts_water)::int as compressor_starts_water
        from source
        group by date_trunc('year', month)
        order by year desc
    )

select *
from yearly_values
