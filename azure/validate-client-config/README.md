# Validate Azure Client Config

Validates that terraform actually authenticated against Azure as the expected identity — the Azure analog of `misc/validate-assume-role`.

Two layers of validation:

1. `data "azurerm_subscription"` performs a real, authenticated ARM read. This forces the provider to acquire an AAD access token (for OIDC auth: exchanging the federated token as the configured client id) — if authentication is broken the plan fails here.
2. A plan-time precondition asserts the authenticated `client_id` matches the `expected_client_id` variable. AAD only issues a token for a client whose federated credential trusts the presented token, so a successful ARM read plus this check pins the deployment to the expected service principal.

No Azure resources are created; Reader on the subscription is enough.

Used by env0's template-integration tests to verify deployments authenticate via an `AZURE_OIDC` deployment credential.

## Variables

- `expected_client_id` — the client id (application id) terraform is expected to authenticate as.
