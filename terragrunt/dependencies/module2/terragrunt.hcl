include "temp" {
  path = "${dirname(find_in_parent_folders())}/__inputs/temp2.hcl"
}


generate "null_resource" {
  path = "tg.main.tf"
  if_exists = "overwrite_terragrunt"
  contents = <<EOF
resource "null_resource" "null-module2" {
}
EOF
}
