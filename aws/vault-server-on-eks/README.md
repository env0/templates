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
