dbt run-operation generate_source --args '{"schema_name": "raw", "database_name": "smarthome_dwh", "table_names":["novelan_heatpump_v1"], "generate_columns": true}'
dbt --quiet run-operation generate_source --args '{"schema_name": "raw", "database_name": "smarthome_dwh", "table_names":["novelan_heatpump_v1"], "generate_columns": true}' > models/sources/novelan/_novelan__sources_v1.yml

source dbt_packages/codegen/bash_scripts/base_model_creation.sh "novelan" ["heatpump"]
dbt run-operation codegen.create_base_models --args '{source_name: novelan, tables: ["heatpump"]}'


dbt run-operation generate_base_model --args '{"source_name": "raw", "table_name": "novelan_heatpump_v1"}'
dbt run-operation generate_base_model --args '{"source_name": "raw", "table_name": "novelan_heatpump_v2"}'


dbt run-operation generate_model_yaml --args '{"model_names": ["stg_novelan__heatpumps_v1"]}'
dbt run-operation generate_model_yaml --args '{"model_names": ["stg_novelan__heatpumps_v2"]}'
dbt run-operation generate_model_yaml --args '{"model_names": ["stg_novelan__heatpumps"]}'
dbt run-operation generate_model_yaml --args '{"model_names": ["heatpump_compressor_usage"]}'
dbt run-operation generate_model_yaml --args '{"model_names": ["heatpump_heat_quantities_daily"]}'
dbt run-operation generate_model_yaml --args '{"model_names": ["heatpump_heat_quantities_monthly"]}'
dbt run-operation generate_model_yaml --args '{"model_names": ["heatpump_heat_quantities_yearly"]}'
dbt run-operation generate_model_yaml --args '{"model_names": ["heatpump_heat_quantities"]}'
dbt run-operation generate_model_yaml --args '{"model_names": ["heatpump_temperatures"]}'


