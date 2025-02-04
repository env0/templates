terraform {
  required_version = ">= 1.0"
}

module "remote_state_bucket" {
  source = "github.com/env0/remote-state-bucket-module/aws"
  
  # Module-specific inputs
  external_id        = "ddd43a98-e5a1-46a2-8748-397118c5dfe4"
  state_bucket_name  = "custom-rbe-bucket-integration-tests-states-bucket"
  region             = "us-west-2"
  env0_aws_role_name = "arn:aws:iam::170412844252:role/remote-backend-bors"
}

output "bucket_name" {
  value = module.remote_state_bucket.bucket_name
}

output "role_arn" {
  value = module.remote_state_bucket.role_arn
}

output "external_id" {
  value = module.remote_state_bucket.external_id
}

output "region" {
  value = module.remote_state_bucket.region
}
