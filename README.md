# Mermaid Postgres Demo

This repository shows how to dynamically create an ER-diagram from a PostgreSQL database using mermerd. The diagram below is created automatically by the CI from the SQL files in [postgres/docker-entrypoint-initdb.d/01_setup.sql](postgres/docker-entrypoint-initdb.d/01_setup.sql).

![DB schema SVG](https://siticom.github.io/postgres-mermaid-demo/db-schema.svg)

See the respective [talk on the FOSSGIS conference](https://pretalx.com/fossgis2025/talk/H33WMC/) (German language).

## Explanation

A step-by-step workflow is here: [.github/workflows/publish-gh-pages.yml](.github/workflows/publish-gh-pages.yml)

1. start a Postgres DB inside the CI using a Docker container
2. run the SQL commands with the table definitions
3. use [mermerd](github.com/KarnerTh/mermerd) to create a [Mermaid](https://mermaid.js.org/) source file. Example: [db-schema.mmd](https://siticom.github.io/postgres-mermaid-demo/db-schema.mmd)
4. use [mmdc](https://www.npmjs.com/package/@mermaid-js/mermaid-cli) to convert the Mermaid source file to a SVG or PNG
5. host it using GitHub Pages

The whole workflow can be done with GitLab CI as well.

## Local Setup on Linux / Mac

```shell
# start postgres
docker compose up -d 

# sourc env variables in current terminal session
source .env

# install mermerd via https://github.com/KarnerTh/mermerd
mermerd \
  -c "postgresql://${POSTGRES_USER}:${POSTGRES_PASSWORD}@${POSTGRES_HOST}:${POSTGRES_PORT}/${POSTGRES_DB}" \
  --schema public \
  --showAllConstraints \
  --ignoreTables spatial_ref_sys \
  --useAllTables

# install mmdc via https://www.npmjs.com/package/@mermaid-js/mermaid-cli
mmdc \
    --input result.mmd \
    --theme forest \
    --output out.svg
```
