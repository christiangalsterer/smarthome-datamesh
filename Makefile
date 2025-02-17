SHELL = /bin/bash

.PHONY: build ci clean duckdb-clean duckdb-ingest motherduck-ingest dbt-build dbt-deps dbt-test dbt-run dbt-docs-generate dbt-docs-serve dbt-docs-build evidence-build evidence-build-strict evidence-dev evidence-install evidence-test evidence-sources evidence-preview pandas-load-data

build: pandas-load-data duckdb-clean duckdb-ingest dbt-build dbt-docs-generate evidence-sources evidence-dev
	@echo "Building...""

ci: clean python-deps duckdb-ingest dbt-deps dbt-build dbt-docs-generate motherduck-ingest evidence-install evidence-sources evidence-test
	@echo "Running CI..."

clean: duckdb-clean
	@echo "Cleaning..."
	rm -rf evidence/node_modules

duckdb-clean:
	@echo "Removing DuckDB database..."
	rm -rf smarthome_dwh.duckdb

duckdb-ingest:
	@echo "Loading data into DuckDB database..."
	source venv/bin/activate && duckdb smarthome_dwh.duckdb < scripts/duckdb_ingest.sql

motherduck-ingest:
	@echo "Loading data into MotherDuck database..."
	source venv/bin/activate && duckdb < scripts/motherduck_ingest.sql

pandas-load-data: python-deps
	@echo "Loading data with pandas..."
	source venv/bin/activate && python pandas/novelan_compressor_starts.py	

dbt-build:
	@echo "Building dbt models..."
	source venv/bin/activate && dbt build

dbt-deps:
	@echo "Installing dbt dependencies..."
	source venv/bin/activate && dbt deps

dbt-test:
	@echo "Testing dbt models..."
	source venv/bin/activate && dbt test

dbt-run:
	@echo "Running dbt models..."
	source venv/bin/activate && dbt run

dbt-docs-generate:
	@echo "Generating dbt documentation..."
	source venv/bin/activate && dbt docs generate

dbt-docs-serve:
	@echo "Serving dbt documentation..."
	source venv/bin/activate && dbt docs serve

dbt-docs-build: dbt-docs-generate dbt-docs-serve
	@echo "Building dbt documentation..."

evidence-build:
	@echo "Building Evidence..."
	npm run build --prefix evidence

evidence-build-strict:
	@echo "Building strict Evidence..."
	npm run build:strict --prefix evidence

evidence-dev:
	@echo "Running Evidence..."
	npm run dev --prefix evidence

evidence-install:
	@echo "Installing Evidence dependencies..."
	npm install --prefix evidence

evidence-test:
	@echo "Testing Evidence..."
	npm run test --prefix evidence

evidence-sources:
	@echo "Generating Evidence sources..."
	npm run sources --prefix evidence

evidence-preview:
	@echo "Previewing Evidence..."
	npm run preview --prefix evidence

metabase-run:
	@echo "Running Metabase..."
	docker compose -f metabase/docker-compose.yml up
	open http://localhost:4000

python-deps:
	@echo "Installing Python dependencies..."
	python3 -m venv venv
	source venv/bin/activate && pip-compile && pip install -r requirements.txt && poetry install