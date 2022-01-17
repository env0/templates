#!/usr/bin/env bash

if [[ -n "${ENV0_REVIEWER_NAME}" ]]; then
    MESSAGE="${ENV0_DEPLOYMENT_TYPE} deployment approved by: \`${ENV0_REVIEWER_NAME} (${ENV0_REVIEWER_EMAIL})\`"

    __dir="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
    source "${__dir}"/slack.sh "$MESSAGE"
fi
