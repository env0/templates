#!/usr/bin/env bash
set -e
if [[ "$SHAG_FAKE_SECRET" == "FAKE_NEWS" ]];
then
  echo "Loaded secret from SSM successfully"
  exit 0
else
  echo "Validation failed! Value of SSM secret is $SHAG_FAKE_SECRET"
  exit 1
fi
