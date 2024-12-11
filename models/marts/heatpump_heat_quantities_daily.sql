with

source as (

    select * from {{ ref('stg_novelan__heatpumps') }}

),

daily_values as
    (
    select
        wmz_bw,
        strftime(created_date, '%Y-%m-%d') AS Date,
        FIRST_VALUE(wmz_bw) OVER (PARTITION BY strftime(created_date, '%Y-%m-%d') ORDER BY created_date) AS First_Value,
        LAST_VALUE(wmz_bw) OVER (PARTITION BY strftime(created_date, '%Y-%m-%d') ORDER BY created_date ROWS BETWEEN UNBOUNDED PRECEDING AND UNBOUNDED FOLLOWING) AS Last_Value
    from source
)

select * from daily_values

-- select 
--     Date,
--     First_Value,
--     Last_Value,
--     CAST(Last_Value AS DECIMAL) - CAST(First_Value AS DECIMAL) AS WMZ_BW_Difference
-- from daily_values
