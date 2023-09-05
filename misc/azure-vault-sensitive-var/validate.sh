#!/usr/bin/env bash
set -e
if [[ "$AZURE_SHAG_FAKE_SECRET" == "FAKE_NEWS" ]];
then
  echo "Loaded secret from azure vault successfully"
  exit 0
else
  echo "Validation failed! Value of azure vault secret is $AZURE_SHAG_FAKE_SECRET"
  exit 1
fi
