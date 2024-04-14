#!/usr/bin/env bash
set -e
if [[ "$INPUT" == "hello" ]];
then
  echo "Resolved Input correctly"
  exit 0
else
  echo "Didnt resolve input correctly, got - $INPUT"
  exit 1
fi
