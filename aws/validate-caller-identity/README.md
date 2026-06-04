### Validate Caller Identity

Terraform-native validation that env0 authenticated as the expected AWS identity.

Reads `data.aws_caller_identity` (a real authenticated `sts:GetCallerIdentity` call) and fails the apply via a `precondition` unless the assumed ARN contains the substring in the `expected_arn` variable.

Unlike `misc/validate-assume-role` — which validates in a pre-terraform custom-flow step (`setupVariables.after`) — this asserts during terraform apply. That matters for credential types whose AWS credentials are only injected at the `template:init` step (after the custom-flow hook), such as AWS OIDC.
