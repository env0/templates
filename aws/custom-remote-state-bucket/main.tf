terraform {
  required_version = ">= 1.0"
}

module "remote_state_bucket" {
  source = "github.com/env0/remote-state-bucket-module/aws"
  
  # Module-specific inputs
  external_id        = "64922d09-2a1f-4f5b-b978-4f5e18f5e3b6"
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
