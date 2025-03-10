# Mermaid Postgres Demo

This repository contains a demo how to create a diagram of the tables in PostgreSQL database using continuous integration.

![DB schema SVG](https://siticom.github.io/postgres-mermaid-demo/db-schema.svg)

## Local Setup

```shell
docker compose up -d 

source .env

mermerd \
  -c "postgresql://${POSTGRES_USER}:${POSTGRES_PASSWORD}@${POSTGRES_HOST}:${POSTGRES_PORT}/${POSTGRES_DB}" \
  --schema public \
  --showAllConstraints \
  --ignoreTables spatial_ref_sys \
  --useAllTables

mmdc \
    --input result.mmd \
    --theme forest \
    --output out.svg
```
