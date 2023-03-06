# env0 Cost Estimation IAM Role Template

This template creates the IAM role and policy as described in the [How to Setup AWS Costs with env0](https://docs.env0.com/docs/aws-costs) documentation.
The outputs include the role ARN and External Id for use in configuring the credential in env0.

## Setup

Once you've completed the [Getting Started with env0](https://docs.env0.com/docs/getting-started) onboarding process, having connected your VCS and AWS, you can either set this up as a [template](https://docs.env0.com/docs/create-your-first-template) (recommended) to simplify launching new projects (Eg. Dev, Stag, Prod) in the future, or launch it in a [new environment](https://docs.env0.com/docs/setting-up-a-new-environment) (Stack).
(Please env0, correct your terminology to align with the tech industry... Docs are so hard.)

Once the stack has completed, view the outputs to access the IAM Role ARN and External Id when [adding a new Cost Credential](https://docs.env0.com/docs/aws-costs#add-credentials-to-your-organization) in env0.

