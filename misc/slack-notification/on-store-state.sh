#!/usr/bin/env bash

terraform show -json .tf-plan | jq --sort-keys '.values' > plan.json
terraform show -json | jq --sort-keys '.planned_values' > state.json

difference=diff plan.json state.json
if (( ${#difference}==0 )); then
  echo 'no change'
else
  echo 'change'
fi

