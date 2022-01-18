#!/usr/bin/env bash

difference=$(diff plan.json state.json)

if [ -f apply ]; then
  echo 'was apply'
else
  if (( ${#difference}==0 )); then
    echo 'no change'
  else
    echo 'change'
  fi
fi
