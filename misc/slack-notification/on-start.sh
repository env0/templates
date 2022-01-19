#!/usr/bin/env bash

if [[ -z "${ENV0_REVIEWER_NAME}" ]]; then
  ACTION="Started"
else
  ACTION="Continued"
fi

MESSAGE="${ACTION} running \`${ENV0_DEPLOYMENT_TYPE}\` deployment."

__dir="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
source "${__dir}"/slack.sh "$MESSAGE"

# Making sure we don't have the apply file as we need it to decide if we ran apply or not
touch apply_ran_successfully
rm apply_ran_successfully
