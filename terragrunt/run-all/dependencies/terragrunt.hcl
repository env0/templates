generate "null_resource" {
  path = "tg.main.tf"
  if_exists = "overwrite_terragrunt"
  contents = <<EOF
  module "consul" {
    source = "github.com/env0/templates.git"
  }
EOF
}
##
