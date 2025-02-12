with

    source as (select * from {{ ref("stg_novelan__heatpumps") }}),

    heat_quantities as (

        select created_at, created_date, heat_quantity_heating, heat_quantity_water
        from source
        where heat_quantity_heating is not null and heat_quantity_water is not null
        order by created_at desc
    )

select *
from heat_quantities
