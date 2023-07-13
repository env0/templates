generate "null_resource" {
  path = "module3.tf"
  if_exists = "overwrite_terragrunt"
  contents = <<EOF
resource "null_resource" "module3" {

}
EOF
}

inputs = {
  my_value = "module3_value"
}

generate "output" {
  path = "output.tf"
  if_exists = "overwrite_terragrunt"
  contents = <<EOF
output "my_value" {
  value = var.my_value
}
EOF
}

dependency "module4" {
  config_path = "../module4"

  mock_outputs = {
    my_value = "module2"
  }
}

generate "variables" {
  path = "variables.tf"
  if_exists = "overwrite_terragrunt"
  contents = <<EOF
variable "my_value" {}
EOF
}
