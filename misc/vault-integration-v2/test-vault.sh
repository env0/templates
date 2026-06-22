#!/bin/bash
set -e

if [[ -z "$VAULT_ADDR" || -z "$VAULT_NAMESPACE" || -z "$VAULT_ROLE" ]]; then
    echo "MISSING REQUIRED VARIABLES: VAULT_ROLE, VAULT_NAMESPACE, VAULT_ADDR"
    exit 1
fi

# Prefer the v2 per-provider token (aud=api://env0-vault); fall back to the legacy shared token.
OIDC_TOKEN="${ENV0_VAULT_OIDC_TOKEN:-${ENV0_OIDC_TOKEN:-}}"
if [[ -z "$OIDC_TOKEN" ]]; then
    echo "MISSING REQUIRED VARIABLES: ENV0_VAULT_OIDC_TOKEN or ENV0_OIDC_TOKEN"
    exit 1
fi
echo "Logging in to Vault"

VAULT_TOKEN=$(./vault write auth/env0-jwt-v2/login role="${VAULT_ROLE}" jwt="${OIDC_TOKEN}" -format=json | jq --raw-output '.auth.client_token')
export VAULT_TOKEN

echo "Running some Vault commands"

./vault kv put -mount=secrets-for-env0-v2 creds passcode=my-long-passcode
./vault kv get -mount=secrets-for-env0-v2 -field=passcode creds
