#!/bin/bash
set -e

./vault write auth/jwt/login role="${VAULT_ROLE}" jwt="${ENV0_OIDC_TOKEN}"
echo "Putting vault key value"
./vault kv put -mount=oidc-test creds passcode=my-long-passcode
echo "Getting vault key value"
./vault kv get -mount=oidc-test -field=passcode creds