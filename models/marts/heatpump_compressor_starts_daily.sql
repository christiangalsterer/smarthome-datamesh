WITH

source AS (

    SELECT * FROM {{ ref('heatpump_compressor_starts') }}

),

compressor_starts AS (
    SELECT 
        created_at, 
        created_date, 
        compressor_heating,
        CASE WHEN compressor_heating = 1 AND lag(compressor_heating) OVER (ORDER BY created_at) = 0 THEN 1 ELSE 0 END AS compressor_heating_starts,
        CASE WHEN compressor_water = 1 AND lag(compressor_water) OVER (ORDER BY created_at) = 0 THEN 1 ELSE 0 END AS compressor_water_starts
    FROM source
)
SELECT 
    date_trunc('day', created_date) AS day,
    SUM(compressor_heating_starts)::int AS compressor_heating_starts,
    SUM(compressor_water_starts)::int AS compressor_water_starts
FROM compressor_starts
GROUP BY 
    date_trunc('day', created_date)
ORDER BY
    date_trunc('day', created_date) DESC
