## Description
This terraform template creates a GCP [service account](https://cloud.google.com/iam/docs/service-accounts#what_are_service_accounts) under your project and configures & exports a JSON key for that account 

## Required environment variables:

- `GOOGLE_CREDENTIALS` - You need to download a JSON [service-account key](https://cloud.google.com/iam/docs/creating-managing-service-account-keys#creating_service_account_keys), and copy paste that
- `GOOGLE_PROJECT` - The name of the GCP project.

## Relevant Outputs:
- `public key` - The public key, base64 encoded
- `private_key` - The private key in JSON format, base64 encoded.


For additional info, please visit terraform's [official docs](https://www.terraform.io/docs/providers/google/r/google_service_account_key.html).