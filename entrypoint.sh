#!/bin/bash
set -e

rm -f /donates-time-api/tmp/pids/server.pid
# bin/rails db:drop
# bin/rails db:create
# bin/rails db:migrate

exec "$@"
