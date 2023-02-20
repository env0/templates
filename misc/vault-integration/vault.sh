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
if [[ ! -z "$VAULT_TOKEN" ]]; then
    echo '1.1 Found VAULT_TOKEN, creating JWT role... '
    # CREATION
    # VAULT_TOKEN IS REQUIRED FOR CREATION
    echo "VAULT_ADDR: ${VAULT_ADDR}"
    echo "VAULT_NAMESPACE: ${VAULT_NAMESPACE}"
    echo "VAULT_ROLE: ${VAULT_ROLE}"

    if [[ $STAGE == "prod" ]]; then
      ENV0_BOUND_AUDIENCE="https://prod.env0.com"
      AUTH0_BOUND_AUDIENCE="https://env0.auth0.com/userinfo"
    else
      ENV0_BOUND_AUDIENCE="https://dev.env0.com"
      AUTH0_BOUND_AUDIENCE="https://dev-env0.auth0.com/userinfo"
    fi

  ./vault write auth/jwt/role/"${VAULT_ROLE}" - <<EOF
{
  "user_claim": "sub",
  "role_type": "jwt",
  "bound_audiences": [
    "$ENV0_BOUND_AUDIENCE",
    "$AUTH0_BOUND_AUDIENCE"
  ],
  "bound_claims": {
    "https://env0.com/organization": "$ENV0_ORGANIZATION_ID",
    "https://env0.com/apiKeyType": "oidc"
  }
}
EOF
echo "================="
fi


echo "2. Logging in using JWT"
#USAGE
if ! ./vault write auth/jwt/login role="${VAULT_ROLE}" jwt="${ENV0_OIDC_TOKEN}" ;# IF IT WORKS - YOU SHOULD SUCCESSFULLY SEE THE KEYS
then
  exit 1
fi

echo "================="
echo "Done."
