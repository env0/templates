#!/usr/bin/env bash

if [[ -z "${ENV0_REVIEWER_NAME}" ]]; then
  ACTION="Started"
else
  ACTION="Continued"
fi

MESSAGE="${ACTION} running \`${ENV0_DEPLOYMENT_TYPE}\` deployment."

__dir="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
source "${__dir}"/slack.sh "$MESSAGE"


touch apply
rm apply