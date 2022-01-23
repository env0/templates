#!/usr/bin/env bash

if [[ -z "${ENV0_REVIEWER_NAME}" ]]; then
  ACTION="Started"
else
  ACTION="Continued"
fi

if [ "${ENV0_DEPLOYER_NAME}" = "env0" ]; then
  TRIGGER="System"
else
  TRIGGER="Manual"
fi

MESSAGE="${ACTION} running \`${ENV0_DEPLOYMENT_TYPE}\` deployment.\nTrigger: ${TRIGGER} Run"

__dir="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
source "${__dir}"/slack.sh "$MESSAGE"

rm -f apply_ran_successfully
