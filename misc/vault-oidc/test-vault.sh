#!/bin/bash
set -e

export VAULT_TOKEN=$(./vault write auth/env0-jwt/login role="${VAULT_ROLE}" jwt="${ENV0_OIDC_TOKEN}" -format=json | jq --raw-output '.auth.client_token')

echo "Putting vault key value"
./vault kv put -mount=secrets-for-env0 creds passcode=my-long-passcode
echo "Getting vault key value"
./vault kv get -mount=secrets-for-env0 -field=passcode creds