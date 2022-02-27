#!/bin/bash

docker-compose exec db bash -c "pg_dump -U \${POSTGRES_USER} \${DB_NAME} > /var/lib/postgresql/backup/\"\$(date +'%Y%m%d_%H%M%S')_\${DB_NAME}.sql\""
