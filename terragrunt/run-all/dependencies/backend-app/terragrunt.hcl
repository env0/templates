generate "null_resource" {
  path = "tg.main.tf"
  if_exists = "overwrite_terragrunt"
  contents = <<EOF
resource "null_resource" "null" {
}

module "random-uuid" {
  source = "Invicton-Labs/uuid/random"
}

output "random-uuid" {
  value = module.random-uuid.uuid
}

EOF
}

dependencies {
  paths = ["../vpc"]
}