#!/bin/bash
set -e

sudo docker compose --env-file ../.env "$@"
