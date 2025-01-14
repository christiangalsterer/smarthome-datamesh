with

source as (

    select * from {{ ref('stg_engelmann__sensostar_v1') }}

),

heat_quantities as (

    select
        created_date,
        heat_quantity
    from source
    order by created_date desc
)

select * from heat_quantities