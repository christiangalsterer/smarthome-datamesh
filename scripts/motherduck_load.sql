ATTACH 'md:';
DROP DATABASE IF EXISTS smarthome_dwh;
CREATE DATABASE smarthome_dwh;
USE smarthome_dwh;
CREATE SCHEMA IF NOT EXISTS raw;
CREATE OR REPLACE TABLE raw.novelan_heatpump_v1 AS SELECT * FROM read_csv('ingest/novelan/heatpump/v1/*.csv', decimal_separator = ',');
CREATE OR REPLACE TABLE raw.novelan_heatpump_v2 AS SELECT * FROM read_csv('ingest/novelan/heatpump/v2/*.csv', decimal_separator = ',', types={'AnalogOut_2': 'VARCHAR', 'TBW_Soll': 'VARCHAR'});