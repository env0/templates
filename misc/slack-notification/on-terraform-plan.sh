#!/usr/bin/env bash

terraform show -json .tf-plan | jq --sort-keys '.planned_values' > plan.json
terraform show -json | jq --sort-keys '.values' > state.json
