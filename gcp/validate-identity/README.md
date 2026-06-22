### Validate Identity

Terraform-native validation that env0 authenticated to GCP via a `GCP_OIDC` credential.

Points the `google` provider at the external-account config env0 writes at deploy time (`env0_credential_configuration.json`) and reads `data.google_client_config` — fetching its access token forces the full Workload Identity Federation exchange (env0 OIDC token → STS exchange at the WIF provider → service-account impersonation). A `precondition` fails the apply unless a non-empty access token is obtained.

Because the WIF provider used by each credential accepts only a **single** audience, a successful exchange proves the deploy minted a token with the correct audience — which is what makes the `GCP OIDC (v1 token)` (legacy `aud`) and `GCP OIDC (v2 token)` (`api://env0-gcp`) template-integration tests distinct. (The impersonated SA's email isn't asserted: `google_client_openid_userinfo` returns a null email for service-account tokens, and the audience restriction on the WIF provider is the real discriminator.) The GCP-side trust is provisioned by `tests/terraform/env0-oidc-trust-gcp` in the env0 repo.
