#!/usr/bin/env bash
MESSAGE=$1
ICON_URL="https://uploads-ssl.webflow.com/5ceab5395d0f478e169de7c0/5f21eb54b57c7a8559c68ff7_Env0-Color%20Icon%403x.png"
PAYLOAD="{\"channel\": \"#${SLACK_CHANNEL}\", \"username\": \"webhookbot\", \"text\": \"${MESSAGE}\", \"icon_url\": \"${ICON_URL}\"}"

curl -X POST --data-urlencode "payload=${PAYLOAD}" ${SLACK_URL}
