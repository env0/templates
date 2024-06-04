generate "null_resource" {
  path = "tg.main.tf"
  if_exists = "overwrite_terragrunt"
  contents = <<EOF
terraform {
  required_version = ">= 1.7.0, < 2.0.0"
}
resource "null_resource" "null" {
}
resource "null_resource" "null-2" {
}
EOF
}
