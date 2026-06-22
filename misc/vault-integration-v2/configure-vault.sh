#!/bin/bash
set -e

echo "Installing vault client..."

curl -sL https://releases.hashicorp.com/vault/1.11.1/vault_1.11.1_linux_amd64.zip -o vault1.zip
unzip -o vault1.zip
./vault --version

# The token should only be used to configure vault - after that we will login using OIDC
export VAULT_TOKEN=$VAULT_DEV_ROOT_TOKEN

# Dedicated v2 paths so this never collides with the v1 `misc/vault-integration` template's
# shared `env0-jwt/` auth + `secrets-for-env0/` mount when both deploy concurrently.

# Cleaning up anything previously configured
./vault secrets disable secrets-for-env0-v2/ || true
./vault auth disable env0-jwt-v2/ || true

# Configuring vault
./vault secrets enable -path=secrets-for-env0-v2/ kv

# Bind an ACL policy for permissions
./vault policy write env0-access-v2 - <<EOF
path "secrets-for-env0-v2/*" {
    capabilities = ["read", "create", "update"]
}
EOF

./vault auth enable -path=env0-jwt-v2/ jwt
./vault write auth/env0-jwt-v2/config jwks_url="https://login.dev.env0.com/.well-known/jwks.json"

# The v2 per-provider token carries aud=api://env0-vault (vs the v1 shared aud).
./vault write auth/env0-jwt-v2/role/"$VAULT_ROLE" - <<EOF
{
  "user_claim": "sub",
  "role_type": "jwt",
  "bound_audiences": [
    "api://env0-vault"
  ],
  "bound_claims": {
    "https://env0.com/organization": "$ENV0_ORGANIZATION_ID",
    "https://env0.com/apiKeyType": "oidc"
  },
  "policies": ["env0-access-v2"]
}
EOF
