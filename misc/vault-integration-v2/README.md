### Vault Integration test template (v2 token)

- v2 variant of `misc/vault-integration`: exercises the JWT integration with a running Vault server using the **per-provider-audience v2 OIDC token** (`aud = api://env0-vault`) instead of the legacy shared-`aud` token.
- `configure-vault.sh` sets up a JWT auth role whose `bound_audiences` is `["api://env0-vault"]`, on **dedicated paths** — auth `env0-jwt-v2/`, secrets mount `secrets-for-env0-v2/`, policy `env0-access-v2`. These never touch the v1 template's shared `env0-jwt/` / `secrets-for-env0/`, so the v1 and v2 entries can deploy concurrently without racing.
- `test-vault.sh` logs in using `$ENV0_VAULT_OIDC_TOKEN` (the v2 per-provider token), falling back to `$ENV0_OIDC_TOKEN`.
- `VAULT_ROLE`, `VAULT_NAMESPACE`, `VAULT_ADDR`, `VAULT_DEV_ROOT_TOKEN` - these should be supplied as env vars to the deployment. See `aws/vault-server-on-eks/README.md` for more info.
