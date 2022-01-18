#!/usr/bin/env bash

terraform show -json .tf-plan > plan.json
terraform show -json > state.json

difference=diff <(jq --sort-keys '.values' state.json) <(jq --sort-keys '.planned_values' plan.json)
if (( ${#difference}==0 )); then
  echo 'no change'
else
  echo 'change'
fi

