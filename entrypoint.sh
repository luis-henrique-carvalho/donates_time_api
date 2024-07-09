#!/bin/bash
set -e

rm -f /donates-time-api/tmp/pids/server.pid

exec "$@"
