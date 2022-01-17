# Env0 Deployment Slack Notifications

Sends a Slack message for multiple events:
* Deploy start
* Destroy start
* Deploy failed
* Destroy failed
* Deploy approved
* Destroy approved

For this to work the following environment variables should be provided

* `SLACK_URL` - The webhook url to post to (found in [Slack](https://env0.slack.com/apps/A0F7XDUAZ-incoming-webhooks))

* `SLACK_CHANNEL` - The channel name to send the message to (without `#`) 