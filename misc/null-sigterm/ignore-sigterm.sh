#!/usr/bin/env bash
# no-sigterm.sh
trap "" SIGTERM
exec "$@"
