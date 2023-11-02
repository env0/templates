#!/bin/bash
set -e

./vault write auth/jwt/login role="${VAULT_ROLE}" jwt="${ENV0_OIDC_TOKEN}"
echo "Running some Vault commands"
./vault kv put -mount=oidc-test creds passcode=my-long-passcode
./vault kv get -mount=oidc-test -field=passcode creds