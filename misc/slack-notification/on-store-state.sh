#!/usr/bin/env bash

diff <(terraform show -json .tf-plan | jq --sort-keys '.values') <(terraform show -json | jq --sort-keys '.planned_values')
