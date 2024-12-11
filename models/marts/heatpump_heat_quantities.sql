with

source as (

    select * from {{ ref('stg_novelan__heatpumps') }}

),

heat_quantities as (

    select
        created_at,
        created_date,
        wmz_bw as heat_quantity_water,
        wmz_hz as heat_quantity_heating
    from source
)

select * from heat_quantities