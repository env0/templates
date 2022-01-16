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

PAYLOAD="{\"channel\": \"#${SLACK_CHANNEL}\", \"username\": \"webhookbot\", \"text\": \"${MESSAGE}\", \"icon_emoji\": \":ghost:\"}"

curl -X POST --data-urlencode "payload=${PAYLOAD}" ${SLACK_URL}
