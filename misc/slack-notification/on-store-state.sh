#!/usr/bin/env bash

__dir="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"

if [ -f apply_ran_successfully ]; then
  echo 'apply step ran, not waiting for approval'
else
  MESSAGE="Environment \`${ENV0_ENVIRONMENT_NAME}\` is waiting for approval."
  source "${__dir}"/slack.sh "$MESSAGE"
fi
