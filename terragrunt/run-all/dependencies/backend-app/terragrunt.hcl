generate "null_resource" {
  path = "tg.main.tf"
  if_exists = "overwrite_terragrunt"
  contents = <<EOF
resource "null_resource" "null" {
    count = 2
}

module "random-uuid" {
  source = "Invicton-Labs/uuid/random"
  version = "0.2.0"
}

output "random-uuid" {
  value = module.random-uuid.uuid
}

EOF
}

dependencies {
  paths = ["../vpc"]
}
