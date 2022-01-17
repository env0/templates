#!/usr/bin/env bash

MESSAGE="Failed running \`${ENV0_DEPLOYMENT_TYPE}\` deployment."

__dir="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
source "${__dir}"/slack.sh "$MESSAGE"
