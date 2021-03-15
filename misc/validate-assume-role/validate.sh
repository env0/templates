#!/usr/bin/env bash
set -e

if [[ "$EXPECTED_ARN" == "" ]]
  then
    echo "Missing var EXPECTED_ARN"
    exit 1
fi

export ASSUMED_ARN=$(aws sts get-caller-identity --query Arn)

echo "Assumed Role $ASSUMED_ARN"

if [[ ! "$ASSUMED_ARN" =~ "$EXPECTED_ARN" ]]
  then
    echo "Assumed role expectation failed"
    exit 1
fi

echo "Assumed role expectation passed"
