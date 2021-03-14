#!/usr/bin/env bash
set -e

[[ "$EXPECTED_ARN" == "" ]] && echo "Missing var EXPECTED_ARN" && exit 1

export ASSUMED_ARN=$(aws sts get-caller-identity --query Arn)

echo "Assumed Role $ASSUMED_ARN"

[[ ! "$ASSUMED_ARN" =~ "$EXPECTED_ARN" ]] && echo "Assumed role expectation failed" && exit 1
