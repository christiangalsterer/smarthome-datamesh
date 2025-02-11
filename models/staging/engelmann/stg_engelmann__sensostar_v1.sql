with source as (

    select * from {{ source('engelmann', 'engelmann_sensostar_v1') }}

),

renamed as (

    select
        created_date,
        meter_id,
        heat_quantity,
        heat_quantity_type,
        cost_center

    from source

)

select * from renamed