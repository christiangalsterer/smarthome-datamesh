with

    source as (select * from {{ ref("heatpump_compressor_starts") }}),

    compressor_starts as (
        select
            created_at,
            created_date,
            compressor_start_heating,
            case
                when
                    compressor_start_heating = 1
                    and lag(compressor_start_heating) over (order by created_at) = 0
                then 1
                else 0
            end as compressor_starts_heating,
            case
                when
                    compressor_start_water = 1
                    and lag(compressor_start_water) over (order by created_at) = 0
                then 1
                else 0
            end as compressor_starts_water
        from source
    )
select
    date_trunc('day', created_date) as day,
    sum(compressor_starts_heating)::int as compressor_starts_heating,
    sum(compressor_starts_water)::int as compressor_starts_water
from compressor_starts
group by date_trunc('day', created_date)
order by date_trunc('day', created_date) desc
