#!/bin/sh

BASE_DIR=$(cd "$(dirname "$0")"; pwd)

docker-compose \
  -f "$BASE_DIR/../shared_docker/prometheus.yml" \
  -f "$BASE_DIR/../shared_docker/postgres.yml" \
  -f "$BASE_DIR/../shared_docker/grafana.yml" \
  -f "$BASE_DIR/web_app_docker.yml" \
  "$@"
