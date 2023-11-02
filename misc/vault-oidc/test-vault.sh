#!/bin/bash
set -e

echo "Installing vault client..."

curl -sL https://releases.hashicorp.com/vault/1.11.1/vault_1.11.1_linux_amd64.zip -o vault1.zip
unzip -o vault1.zip
./vault --version

echo "Logging in to Vault"

export VAULT_TOKEN=$(./vault write auth/jwt/login role="${VAULT_ROLE}" jwt="${ENV0_OIDC_TOKEN}" -format=json | jq --raw-output '.auth.client_token')

echo "Running some Vault commands"

./vault kv put -mount=secrets-for-env0 creds passcode=my-long-passcode
./vault kv get -mount=secrets-for-env0 -field=passcode creds
        