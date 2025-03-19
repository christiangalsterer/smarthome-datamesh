with

    source as (select * from {{ ref("meter_heat_quantities") }}),

    yearly_values as (
        select
            date_trunc('year', created_date) as year,
            max(heat_quantity) - min(heat_quantity) as heat_quantity,
        from source
        where heat_quantity
        group by date_trunc('year', created_date)
        order by year desc
    )

select *
from yearly_values
