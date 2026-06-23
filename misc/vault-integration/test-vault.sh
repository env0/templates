#!/bin/bash
set -e

if [[ -z "$VAULT_ADDR" || -z "$VAULT_NAMESPACE" || -z "$VAULT_ROLE" ]]; then
    echo "MISSING REQUIRED VARIABLES: VAULT_ROLE, VAULT_NAMESPACE, VAULT_ADDR"
    exit 1
fi


echo "Logging in to Vault"

export VAULT_TOKEN=$(./vault write auth/env0-jwt/login role="${VAULT_ROLE}" jwt="${ENV0_OIDC_TOKEN}" -format=json | jq --raw-output '.auth.client_token')

echo "Running some Vault commands"

./vault kv put -mount=secrets-for-env0 creds passcode=my-long-passcode
./vault kv get -mount=secrets-for-env0 -field=passcode creds
        