generate "null_resource" {
  path = "tg.main.tf"
  if_exists = "overwrite_terragrunt"
  contents = <<EOF
resource "null_resource" "null" {
}

module "random-uuid" {
  source = "Invicton-Labs/uuid/random"
  version = "0.1.0"
}


EOF
}
