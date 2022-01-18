#!/usr/bin/env bash

difference=diff <(terraform show -json .tf-plan | jq --sort-keys '.values') <(terraform show -json | jq --sort-keys '.planned_values')
if (( ${#difference}==0 )); then
  echo 'no change'
else
  echo 'change'
fi

