with

source as (

    select * from {{ ref('stg_novelan__heatpumps') }}

),

heat_quantities as (

    select
        created_at,
        created_date,
        heat_quantity_water,
        heat_quantity_heating
    from source
    order by created_at desc
)

select * from heat_quantities