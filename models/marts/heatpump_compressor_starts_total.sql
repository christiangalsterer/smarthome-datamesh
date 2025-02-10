with

    source as (select * from {{ ref("stg_novelan__heatpump_compressor_starts_v1") }}),

    compressor_usage as (
        select created_date, created_at, compressor_starts
        from source
        order by created_at desc
    )

select *
from compressor_usage
