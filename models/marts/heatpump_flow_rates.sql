with

    source as (select * from {{ ref("stg_novelan__heatpumps") }}),

    flow_rates as (

        select created_at, created_date, flow_rate
        from source
        where flow_rate is not null
        order by created_at desc
    )

select *
from flow_rates
