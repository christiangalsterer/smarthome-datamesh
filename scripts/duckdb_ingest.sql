CREATE SCHEMA IF NOT EXISTS raw;
CREATE OR REPLACE TABLE raw.novelan_heatpump_v1 AS SELECT DISTINCT ON (Datum, Zeitstempel) * FROM read_csv('data/novelan/heatpump/v1/*.csv', decimal_separator = ',');
CREATE OR REPLACE TABLE raw.novelan_heatpump_v2 AS SELECT DISTINCT ON (Datum, Zeitstempel) * FROM read_csv('data/novelan/heatpump/v2/novelan_heatpump_2*.csv', decimal_separator = ',', types={'AnalogOut_2': 'VARCHAR', 'TBW_Soll': 'DOUBLE'});
CREATE OR REPLACE TABLE raw.engelmann_sensostar_v1 AS SELECT DISTINCT ON (created_date, meter_id) * FROM read_csv('data/engelmann/sensostar/v1/*2*.csv', decimal_separator = ',', types={'meter_id': 'VARCHAR'});
