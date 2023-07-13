generate "null_resource" {
  path = "module2.tf"
  if_exists = "overwrite_terragrunt"
  contents = <<EOF
resource "null_resource" "module2" {

}
EOF
}

dependency "module3" {
  config_path = "../module3"

  mock_outputs = {
    my_value = "module2"
  }
}

inputs = {
  my_value = dependency.module3.outputs.my_value
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

generate "variables" {
  path = "variables.tf"
  if_exists = "overwrite_terragrunt"
  contents = <<EOF
variable "my_value" {}
EOF
}
