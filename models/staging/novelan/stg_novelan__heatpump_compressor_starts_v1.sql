with
    source as (

        select * from {{ source("novelan", "novelan_heatpump_compressor_starts_v1") }}

    ),

    renamed as (select created_date, created_at, compressor_starts from source)

select *
from renamed
