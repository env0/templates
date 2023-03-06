### Vault Integration test template

- This template runs a Hashicorp Vault _client_ that's meant to test the JWT integration with a running Vault server instance.
- It runs the `vault.sh` script which authenticates against vault.
- `VAULT_ROLE`, `VAULT_NAMESPACE`, `VAULT_ADDR`, `VAULT_DEV_ROOT_TOKEN` - these should be supplied as env vars to the deployment. See `aws/vault-server-on-eks/README.md` for more info.
