#!/bin/bash
set -e

if [[ -z "$VAULT_ADDR" || -z "$VAULT_NAMESPACE" || -z "$VAULT_ROLE" ]]; then
    echo "MISSING REQUIRED VARIABLES: VAULT_ROLE, VAULT_NAMESPACE, VAULT_ADDR"
    exit 1
fi

echo "Installing vault..."

curl -sL https://releases.hashicorp.com/vault/1.11.1/vault_1.11.1_linux_amd64.zip -o vault1.zip
unzip -o vault1.zip
./vault --version

echo "Running some vault commands"

./vault write auth/env0-jwt/login role="${VAULT_ROLE}" jwt="${ENV0_OIDC_TOKEN}"
./vault kv put -mount=secrets-for-env0 creds passcode=my-long-passcode
./vault kv get -mount=secrets-for-env0 -field=passcode creds
        