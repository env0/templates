#!/usr/bin/env bash
set -e
if [[ "$IS_REDEPLOY" == "true" ]];
then
  EXPECTED_PLAN_OUTPUT="Plan: 0 to add, 0 to change, 0 to destroy."
  PLAN_OUTPUT=$(terraform show -no-color .tf-plan | tail -1)
  if [[ "$PLAN_OUTPUT" == "$EXPECTED_PLAN_OUTPUT" ]];
  then
    echo "Redeploy plan is OK"
    exit 0
  else
    echo "Validation Failed, Redeploy plan is $PLAN_OUTPUT";
    exit 1
  fi
else
  echo "Not Redeploy so not validating"
fi
