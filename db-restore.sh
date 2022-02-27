#!/bin/bash

docker-compose exec db bash -c "psql -h localhost -U \${POSTGRES_USER} -c 'DROP DATABASE IF EXISTS '\${DB_NAME}"
docker-compose exec db bash -c "psql -h localhost -U \${POSTGRES_USER} -c 'CREATE DATABASE '\${DB_NAME}"
docker-compose exec db bash -c "psql -h localhost -U \${POSTGRES_USER} -d \${DB_NAME} -f /var/lib/postgresql/backup/\${DB_RESTORE_FILE}"
docker-compose exec ruby bash -c "rails db:migrate"
