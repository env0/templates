#!/usr/bin/env bash

MESSAGE="Successfully finished running '${ENV0_DEPLOYMENT_TYPE}' deployment on"

if [[ -z "${ENV0_DEPLOYMENT_REVISION}" ]]; then
  MESSAGE="${MESSAGE} repository's default branch.\n"
else
  MESSAGE="${MESSAGE} revision '${ENV0_DEPLOYMENT_REVISION}'.\n"
fi

if [[ -z "${ENV0_REVIEWER_NAME}" ]]; then
  MESSAGE="${MESSAGE} Automatically approved."
else
  MESSAGE="${MESSAGE} Approved by: ${ENV0_REVIEWER_NAME}(${ENV0_REVIEWER_EMAIL})"
fi

__dir="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
source ${__dir}/slack.sh "$MESSAGE"
