# Description

This template demonstrates how to use custom profiles for a remote backend, and have the terraform plan and apply run with different credentials.
[Profile is ignored when using AWS_ACCESS_KEY_ID](https://github.com/hashicorp/terraform-provider-aws/issues/10698). Also, using `AWS_PROFILE` is impossible before actually defining the profile.
Therefore, the nicest way to accomplish this would be to dynamically define two profiles:
1. custom-profile - the profile that will run the backend
2. default - the profile that will run the plans and applies

# Prerequisites

1. Make sure the backend bucket already exists in the custom profile's account
2. Replace `PROFILE_AWS_REGION`, `PROFILE_AWS_KEY`, `PROFILE_AWS_SECRET` with the credentials for the custom profile.
3. Replace `DEFAULT_AWS_REGION`, `DEFAULT_AWS_KEY`, `DEFAULT_AWS_SECRET` with the credentials that should run the plan and apply.