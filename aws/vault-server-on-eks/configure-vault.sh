#!/usr/bin/env bash
set -e

# INSTALLING VAULT
echo "1. Installing vault..."
curl -sL https://releases.hashicorp.com/vault/1.11.1/vault_1.11.1_linux_amd64.zip -o vault1.zip
unzip -o vault1.zip
./vault --version

export VAULT_ADDR=http://$(kubectl get service self-hosted-vault-ui -n self-hosted-vault -o jsonpath='{.status.loadBalancer.ingress[0].hostname}'):8200
export VAULT_TOKEN=$TF_VAR_dev_root_token

# Configuring vault
# # Create KV store type
vault secrets enable -path=secrets-for-env0/ kv

# # Bound a ACL policy for permissions
vault policy write env0-access - <<EOF
path "secrets-for-env0/*" {
    capabilities = ["read", "create", "update"]
}
EOF

vault auth enable -path=env0-jwt/ jwt
vault write auth/env0-jwt/config jwks_url="https://login.app.env0.com/.well-known/jwks.json"

# # Create auth for our bors integration tests org 

export BORS_TEST_ORG_ID="214afc56-607b-447a-a533-5f3f6d608539"
export ROLE_NAME=bors-env0-integration-tests-role

vault write auth/env0-jwt/role/$ROLE_NAME - <<EOF
{
  "user_claim": "sub",
  "role_type": "jwt",
  "bound_audiences": [
    "https://dev.env0.com",
    "https://dev-env0.auth0.com/userinfo"
  ],
  "bound_claims": {
    "https://env0.com/organization": "$BORS_TEST_ORG_ID",
    "https://env0.com/apiKeyType": "oidc"
  },
  "policies": ["env0-access"]
}
EOF
‍
echo $VAULT_ADDR
