#!/bin/bash
set -e

echo "Installing vault client..."

curl -sL https://releases.hashicorp.com/vault/1.11.1/vault_1.11.1_linux_amd64.zip -o vault1.zip
unzip -o vault1.zip
./vault --version

# The token should only be used to configure vault - after that we will login using OIDC
export VAULT_TOKEN=$VAULT_DEV_ROOT_TOKEN

# Cleaning up anything previously configured
./vault secrets disable secrets-for-env0/ || true
./vault auth disable env0-jwt/ || true

# Configuring vault
./vault secrets enable -path=secrets-for-env0/ kv

# # Bound a ACL policy for permissions
./vault policy write env0-access - <<EOF
path "secrets-for-env0/*" {
    capabilities = ["read", "create", "update"]
}
EOF

./vault auth enable -path=env0-jwt/ jwt
./vault write auth/env0-jwt/config jwks_url="https://login.dev.env0.com/.well-known/jwks.json"

./vault write auth/env0-jwt/role/$VAULT_ROLE - <<EOF
{
  "user_claim": "sub",
  "role_type": "jwt",
  "bound_audiences": [
    "https://dev.env0.com",
    "https://dev-env0.auth0.com/userinfo"    
  ],
  "bound_claims": {
    "https://env0.com/organization": "$ENV0_ORGANIZATION_ID",
    "https://env0.com/apiKeyType": "oidc"
  },
  "policies": ["env0-access"]
}
EOF
