#!/bin/bash
set -e

echo "Running some Vault commands"

./vault kv put -mount=secrets-for-env0 creds passcode=my-long-passcode
./vault kv get -mount=secrets-for-env0 -field=passcode creds
        