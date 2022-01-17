# Env0 Deployment Slack Notifications

[comment]: <> (TODO: Update)

Sends a Slack message for either deploy/destroy, done in the `onSuccess` stage.

For this to work the following environment variables should be provided

* `SLACK_URL` - The webhook url to post to (found in [Slack](https://env0.slack.com/apps/A0F7XDUAZ-incoming-webhooks))

* `SLACK_CHANNEL` - The channel name to send the message to (without `#`) 