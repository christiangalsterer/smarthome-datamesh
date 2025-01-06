with

source as (

    select * from {{ ref('stg_novelan__heatpumps') }}

),

temperatures as (

    select
        created_at,
        created_date,
        ta as temp_outside
    from source
    order by created_at desc

)

select * from temperatures