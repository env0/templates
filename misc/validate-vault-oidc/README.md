### Validate Vault OIDC

Terraform-native validation that env0 authenticated to Vault via a `VAULT_OIDC` credential — used by **both** the v1 (legacy shared-`aud`) and v2 (`api://env0-vault`) test entries. A new template (rather than modifying `misc/vault-integration`) so merging this PR doesn't change the template the existing `Vault OIDC Integration` test currently uses.

The `VAULT_OIDC` credential's `setup-oidc-vault` step logs into the JWT role provisioned out-of-band by `tests/terraform/env0-oidc-trust-vault` (env0 repo) using the env0 OIDC token, and exports `VAULT_TOKEN`. This template's `vault` provider uses that token (+ `VAULT_ADDR`) to **read** a secret the fixture seeded; a `precondition` fails the apply unless the value comes back as expected. If the OIDC login failed (wrong audience/claims), the deploy already failed at the credential step.

The only per-version difference is the KV mount, passed via `TF_VAR_secrets_mount`:
- **v1** — credential `jwtAuthBackendPath=env0-jwt`; default mount `secrets-for-env0`.
- **v2** — credential `jwtAuthBackendPath=env0-jwt-v2` + `tokenFormat: "v2"`; entry sets `TF_VAR_secrets_mount=secrets-for-env0-v2`.

Fully credential-driven (no deploy-time script or `VAULT_DEV_ROOT_TOKEN`) — same shape as `aws/validate-caller-identity` / `gcp/validate-identity`.
