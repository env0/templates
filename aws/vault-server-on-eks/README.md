# Vault Server on EKS template

- Creates a very basically configured Vault server to run on our EKS cluster
- Used to test integration with Vault
- This server is not meant for any actual production/secret use - it's configured as lightly as possible.

## Expected variables

- AWS credentials
- `TF_VAR_cluster_name` - the cluster name to install the Vault server in
- `TF_VAR_dev_root_token` - the root token (password) that will be needed to login to Vault
- `VAULT_ROLE` - The Vault role name (that will be created)
- `VAULT_NAMESPACE` - The Vault namespace to use

## Outputs

- This Vault instance is expected to be used in our integration tests, which run `misc/vault-integration`
- That script needs `VAULT_ROLE` & `VAULT_NAMESPACE` that were defined here
- And `VAULT_DEV_ROOT_TOKEN` which is the `TF_VAR_dev_root_token` defined here
- And also `VAULT_ADDR` which the script here outputs in the end

## Vault init

- Exec into one of the vault pods and run `vault operator init`. Save the Unseal Keys and root token.
- Run `vault operator unseal`. Enter the Unseal keys and the root token to unseal the Vault. You might need to this a couple of times until the Vault actually stays unsealed (or on the different pods) :/ Vault takes a while to stabilize because it has some cluster balancing thingy. You want the vault to be unsealed - otherwise it can't be used.
- Save the root token - that's what we'll use for auth.
