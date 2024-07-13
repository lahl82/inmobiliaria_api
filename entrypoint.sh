#!/bin/bash
set -e

# Elimina el archivo PID del servidor si existe
rm -f /app/tmp/pids/server.pid

# Esperar a que la base de datos esté lista
until pg_isready -h db -p 5432 -U postgres; do
  echo "Waiting for postgres..."
  sleep 2
done

# Crear la base de datos
bundle exec rails db:create

# Ejecutar migraciones y arrancar el servidor
bundle exec rails db:migrate
bundle exec rails server -b 0.0.0.0
# #!/usr/bin/env bash
# # wait-for-it.sh

# set -e

# host="$1"
# shift
# cmd="$@"

# until pg_isready -h "$host"; do
#   >&2 echo "Postgres is unavailable - sleeping"
#   sleep 1
# done

# >&2 echo "Postgres is up - executing command"
# exec $cmd
