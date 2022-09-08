#!/usr/bin/env bash
set -e

# INSTALLING VAULT
echo "1. Installing vault..."
curl -sL https://releases.hashicorp.com/vault/1.11.1/vault_1.11.1_linux_amd64.zip -o vault1.zip
unzip -o vault1.zip
./vault --version

aws eks --region=us-east-1 update-kubeconfig --name $TF_VAR_cluster_name

VAULT_HOST=$(kubectl get service self-hosted-vault-ui -n self-hosted-vault -o jsonpath='{.status.loadBalancer.ingress[0].hostname}')

echo "VAULT_HOST is $VAULT_HOST"

export VAULT_ADDR=http://$VAULT_HOST:8200
export VAULT_TOKEN=$TF_VAR_dev_root_token

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
    $CLAIM_AUDIENCES    
  ],
  "bound_claims": {
    "https://env0.com/organization": "$CLAIM_ORG_ID",
    "https://env0.com/apiKeyType": "oidc"
  },
  "policies": ["env0-access"]
}
EOF

echo $VAULT_ADDR
