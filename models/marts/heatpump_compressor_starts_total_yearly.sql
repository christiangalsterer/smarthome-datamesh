with
    source as (select * from {{ ref("heatpump_compressor_starts_total") }}),

    yearly_values as (
        select
            date_trunc('year', created_date) as year,
            max(compressor_starts) - lag(max(compressor_starts)) over (
                order by date_trunc('year', created_date)
            ) as compressor_starts
        from source
        group by date_trunc('year', created_date)
    )

select *
from yearly_values
where compressor_starts is not null
