#!/usr/bin/env bash

MESSAGE="Started running '${ENV0_DEPLOYMENT_TYPE}' on"

if [[ -z "${ENV0_DEPLOYMENT_REVISION}" ]]; then
  MESSAGE="${MESSAGE} repository's default branch"
else
  MESSAGE="${MESSAGE} revision '${ENV0_DEPLOYMENT_REVISION}'"
fi

__dir="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
source ${__dir}/slack.sh "$MESSAGE"
