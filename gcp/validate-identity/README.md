### Validate Identity

Terraform-native validation that env0 authenticated as the expected GCP identity.

Reads `data.google_client_openid_userinfo` (the email of the credentials terraform is actually running as — for Workload Identity Federation, the impersonated service account) and fails the apply via a `precondition` unless that email contains the substring in the `expected_service_account` variable.

Used by the `GCP OIDC (v1 token)` and `GCP OIDC (v2 token)` template-integration tests to assert that a `GCP_OIDC` credential authenticated through the env0 WIF trust as the expected service account. The GCP-side trust is provisioned by `tests/terraform/env0-oidc-trust-gcp` in the env0 repo.
