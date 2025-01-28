
# Specify the Terraform module source
terraform {
  source = "git::https://github.com/terraform-aws-modules/terraform-aws-s3-bucket.git//?ref=v3.11.0"
}

# Define inputs for the Terraform module
inputs = {
  bucket        = "my-example-bucket"
  acl           = "private"
  versioning    = {
    enabled = true
  }
  tags = {
    Environment = "dev"
    Project     = "example-project"
  }
}
