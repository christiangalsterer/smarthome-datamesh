
{{ dbt_utils.union_relations(
    relations=[ref('stg_novelan__heatpumps_v1'), ref('stg_novelan__heatpumps_v2')],
    source_column_name=None
) }}

