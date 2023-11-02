#!/bin/bash
set -e

# The token should only be used to configure vault - after that we will login using OIDC
export VAULT_TOKEN=$VAULT_DEV_ROOT_TOKEN

echo Configuring vault
./vault secrets disable secrets-for-env0/ || true
./vault secrets enable -path=secrets-for-env0/ kv

# Bound a ACL policy for permissions
./vault policy write env0-access - <<EOF
path "secrets-for-env0/*" {
    capabilities = ["read", "create", "update"]
}
EOF

./vault write auth/jwt/role/$VAULT_ROLE - <<EOF
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
