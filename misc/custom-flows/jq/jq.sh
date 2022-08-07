if [[ -z "$PR_NUMBER" || -z "$ENV0_SERVICE" ]]; then
    echo "Must provide PR_NUMBER and ENV0_SERVICE environment variables" 1>&2
    exit 1
fi

echo "PR_NUMBER: ${PR_NUMBER}"
echo "ENV0_SERVICE: ${ENV0_SERVICE}"

echo "==============="
echo "==============="

echo "get api id for your PR..."
REST_API_ID=$(aws apigateway get-rest-apis | jq --arg REST_API_NAME "shared-pr$PR_NUMBER-api" '.items[] | select(.name == $REST_API_NAME) | .id' | tr -d '"')

echo "get validator ID for your service..."
VALIDATOR_ID=$(aws apigateway get-request-validators --rest-api-id $REST_API_ID | jq --arg VALIDATOR_NAME "$ENV0_SERVICE-pr$PR_NUMBER | Validate request body and querystring parameters" '.items[] | select(.name == $VALIDATOR_NAME) | .id' | tr -d '"')

echo "deleting the Request Validator..."
aws apigateway delete-request-validator --rest-api-id $REST_API_ID --request-validator-id $VALIDATOR_ID
