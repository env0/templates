#!/usr/bin/env bash

# Checks for required envars.

required_vars=()
required_vars+=("ENV0_SKIP_WORKSPACE")
  # REF: https://docs.env0.com/docs/additional-controls#skip-workspace-commands
required_vars+=("BACKEND_S3_BUCKET")
required_vars+=("PRODUCT_GROUP_STUB")
required_vars+=("WORKLOAD_ENVIRONMENT")
for envar in "${required_vars[@]}"; do
  if [[ -z ${!envar} ]]; then
    echo -e "\e[01;31mERROR\e[0m: The environment variable '$envar' is required but not set!"
    missing_envar='true'
  fi
done
if [[ "$missing_envar" == 'true' ]]; then
  echo -e "\e[01;31mFATAL\e[0m: Check Failure. Quitting..."
  exit 1
fi
if [[ "$ENV0_SKIP_WORKSPACE" != 'true' ]]; then
  echo -e "\e[01;31mERROR\e[0m: The value for the environment variable 'ENV0_SKIP_WORKSPACE' must be 'true'!"
  echo -e "\e[01;31mFATAL\e[0m: Check Failure. Quitting..."
  exit 1
fi
