with
    source as (select * from {{ ref("heatpump_compressor_starts_total") }}),

    monthly_values as (
        select
            date_trunc('month', created_date) as month,
            max(compressor_starts) - lag(max(compressor_starts)) over (
                order by date_trunc('month', created_date)
            ) as compressor_starts
        from source
        group by date_trunc('month', created_date)
    )

select *
from monthly_values
where compressor_starts is not null
