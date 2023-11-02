#!/bin/bash
set -e

# The token should only be used to configure vault - after that we will login using OIDC
export VAULT_TOKEN=$VAULT_DEV_ROOT_TOKEN

Configuring vault
./vault secrets enable -path=secrets-for-env0/ kv

# Bound a ACL policy for permissions
./vault policy write env0-access - <<EOF
path "secrets-for-env0/*" {
    capabilities = ["read", "create", "update"]
}
EOF
