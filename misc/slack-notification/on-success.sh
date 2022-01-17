#!/usr/bin/env bash

MESSAGE="Successfully finished running '${ENV0_DEPLOYMENT_TYPE}' deployment.\n"

if [[ -z "${ENV0_REVIEWER_NAME}" ]]; then
  MESSAGE="${MESSAGE} Automatically approved."
else
  MESSAGE="${MESSAGE} Approved by: ${ENV0_REVIEWER_NAME}(${ENV0_REVIEWER_EMAIL})"
fi

__dir="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
source "${__dir}"/slack.sh "$MESSAGE"
