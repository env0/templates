#!/usr/bin/env bash

MESSAGE="Started running '${ENV0_DEPLOYMENT_TYPE}' on"

if [[ -z "${ENV0_DEPLOYMENT_REVISION}" ]]; then
  MESSAGE="${MESSAGE} repository's default branch.\n"
else
  MESSAGE="${MESSAGE} revision '${ENV0_DEPLOYMENT_REVISION}'.\n"
fi

__dir="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
source ${__dir}/slack.sh "$MESSAGE"
