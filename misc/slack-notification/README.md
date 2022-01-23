# Env0 Deployment Slack Notifications

Sends a Slack message for multiple events:
* Deploy start
* Destroy start
* Found changes (terraform plan)
* Deploy failed
* Destroy failed
* Waiting for approval
* Deploy approved
* Destroy approved

For this to work the following environment variables should be provided:

* `SLACK_URL` - The webhook url to post to (found in [Slack](https://env0.slack.com/apps/A0F7XDUAZ-incoming-webhooks))
