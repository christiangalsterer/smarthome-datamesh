with

source as (

    select * from {{ ref('stg_novelan__heatpumps') }}

),

temperatures as (

    select
        created_at,
        created_date,
        tvl as temp_vorlauf,
        trl_soll as temp_ruecklauf_soll,
        trl as temp_ruecklauf,
        tvl - trl as temp_delta_t,
        tbw as temp_water,
        tbw_soll as temp_water_soll,
        ta as temp_outside
    from source
    order by created_at desc

)

select * from temperatures