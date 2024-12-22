CREATE SCHEMA IF NOT EXISTS raw;
DROP TABLE IF EXISTS raw.novelan_heatpump;
CREATE TABLE IF NOT EXISTS raw.novelan_heatpump AS SELECT * FROM read_csv('ingest/novelan/heatpump/v2/*.csv', decimal_separator = ',', types={'AnalogOut_2': 'VARCHAR', 'TBW_Soll': 'VARCHAR'});