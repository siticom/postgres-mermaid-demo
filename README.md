# Mermaid Postgres Demo

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
