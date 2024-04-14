#!/usr/bin/env bash
set -e
if [[ "$SENSITIVE" == "sensitive" ]];
then
  echo "Resolved SENSITIVE input correctly"
  exit 0
else
  echo "Didnt resolve SENSITIVE input correctly, got - $SENSITIVE"
  exit 1
fi

if [[ "$NOT_SENSITIVE" == "not sensitive" ]];
then
  echo "Resolved NOT_SENSITIVE input correctly"
  exit 0
else
  echo "Didnt resolve NOT_SENSITIVE input correctly, got - $NOT_SENSITIVE"
  exit 1
fi
