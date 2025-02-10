with

    source as (select * from {{ ref("stg_novelan__heatpump_compressor_starts_v1") }}),

    compressor_usage as (
        select created_date, compressor_starts from source order by created_date desc
    )

select *
from compressor_usage
