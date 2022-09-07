#!/bin/bash

if [[ -z "$VAULT_ADDR" || -z "$VAULT_NAMESPACE" || -z "$VAULT_ROLE" ]]; then
    echo "MISSING REQUIRED VARIABLES: VAULT_ROLE, VAULT_NAMESPACE, VAULT_ADDR"
    exit 1
fi

# INSTALLING VAULT
echo "1. Installing vault..."
curl -sL https://releases.hashicorp.com/vault/1.11.1/vault_1.11.1_linux_amd64.zip -o vault1.zip
unzip -o vault1.zip
./vault --version

echo "================="

echo "2. Logging in using JWT"
#USAGE
if ! ./vault write auth/env0-jwt/login role="${VAULT_ROLE}" jwt="${ENV0_OIDC_TOKEN}" ;# IF IT WORKS - YOU SHOULD SUCCESSFULLY SEE THE KEYS
then
  exit 1
fi

echo "================="
echo "Done."
