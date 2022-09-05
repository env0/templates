### Vault Integration test template

- This template runs a Hashicorp Vault _client_ that's meant to test the JWT integration with a running Vault server instance.
- It runs the `vault.sh` script. which in turn authenticates against vault. It consists of two parts - creating a role, if a $VAULT_TOKEN exists, and actually using the JWT token to login to this role.
- `VAULT_ROLE`, `VAULT_NAMESPACE`, `VAULT_ADDR` - these should be supplied as env vars to the deployment
