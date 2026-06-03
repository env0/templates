# Validate Azure Client Config

Validates that terraform authenticated against Azure as the expected identity — the Azure analog of `misc/validate-assume-role`.

Reads the authenticated principal via `data "azurerm_client_config"` and fails the plan with a precondition if its `client_id` doesn't match the `expected_client_id` variable. No Azure resources are created, so Reader-level permissions are enough.

Used by env0's template-integration tests to verify deployments authenticate via an `AZURE_OIDC` deployment credential.

## Variables

- `expected_client_id` — the client id (application id) terraform is expected to authenticate as.
