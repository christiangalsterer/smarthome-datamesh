with

source as (

    select * from {{ ref('stg_novelan__heatpumps') }}

),

temperatures as (

    select
        created_at,
        tvl as temp_vorlauf,
        trl_soll as temp_ruecklauf_soll,
        trl as temp_ruecklauf
    from source

)

select * from temperatures