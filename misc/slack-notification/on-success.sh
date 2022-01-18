#!/usr/bin/env bash

MESSAGE="Successfully finished running \`${ENV0_DEPLOYMENT_TYPE}\` deployment."

__dir="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
source "${__dir}"/slack.sh "$MESSAGE"

difference=$(diff plan.json state.json)

if [ -f apply ]; then
  ehco 'was apply'
else
  if (( ${#difference}==0 )); then
    echo 'no change'
  else
    echo 'change'
  fi
fi
