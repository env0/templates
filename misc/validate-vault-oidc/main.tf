terraform {
  required_version = ">= 1.5.0"

  required_providers {
    vault = {
      source  = "hashicorp/vault"
      version = "~> 4.0"
    }
  }
}

# VAULT_ADDR + VAULT_TOKEN come from the environment: the VAULT_OIDC credential's setup-oidc-vault
# step authenticates to Vault via the env0 OIDC token (logging into the JWT role provisioned by
# tests/terraform/env0-oidc-trust-vault) and exports VAULT_TOKEN. This template validates that the
# OIDC-obtained token works — it reads a secret the fixture seeded that the role's policy permits.
provider "vault" {}

# KV mount the OIDC role's policy permits. v1 uses secrets-for-env0 (default); the v2 entry passes
# TF_VAR_secrets_mount=secrets-for-env0-v2. The v1/v2 difference is otherwise entirely on the
# credential (jwtAuthBackendPath + tokenFormat → which JWT role/audience is authenticated).
variable "secrets_mount" {
  type    = string
  default = "secrets-for-env0"
}

# The secret is seeded by the env0-oidc-trust-vault fixture (root token); this read with the
# OIDC-authenticated VAULT_TOKEN is the validation — it succeeds only if the credential's OIDC
# login produced a token whose role/policy can read the mount.
data "vault_generic_secret" "creds" {
  path = "${var.secrets_mount}/creds"
}

resource "terraform_data" "validate_read" {
  lifecycle {
    precondition {
      condition     = data.vault_generic_secret.creds.data["passcode"] == "my-long-passcode"
      error_message = "Vault read failed: the OIDC-authenticated token could not read ${var.secrets_mount}/creds (seeded by the trust fixture)."
    }
  }
}
