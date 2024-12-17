with

source as (
    select * from {{ ref('stg_novelan__heatpumps') }}
),

compressor_usage as (
    select
        created_at,
        created_date,
        CASE 
            WHEN bupout = 0 THEN vd1out
            ELSE 0
        END as compressor_heating,
        CASE 
            WHEN bupout = 1 THEN vd1out
            ELSE 0
        END as compressor_water
    from source
    order by created_at desc
)

select * from compressor_usage
