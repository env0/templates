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

ICON_URL="https://uploads-ssl.webflow.com/5ceab5395d0f478e169de7c0/5f21eb54b57c7a8559c68ff7_Env0-Color%20Icon%403x.png"
PAYLOAD="{\"channel\": \"#${SLACK_CHANNEL}\", \"username\": \"webhookbot\", \"text\": \"${MESSAGE}\", \"icon_url\": \"${ICON_URL}\"}"

curl -X POST --data-urlencode "payload=${PAYLOAD}" ${SLACK_URL}
