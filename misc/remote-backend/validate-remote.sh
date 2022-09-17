#!/usr/bin/env bash

EXPECTED_TYPE='remote'
ACTUAL_TYPE=$(cat .terraform/terraform.tfstate | jq -r ".backend.type")
echo "Actual backend type: $ACTUAL_TYPE"
if [[ "$EXPECTED_TYPE" == "$ACTUAL_TYPE" ]];
then
  echo 'backend type is remote. OK'
  exit 0
else
  echo 'backend type is not remote. FAILED'
  exit 1
fi
