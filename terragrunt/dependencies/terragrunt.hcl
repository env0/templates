generate "null_resource" {
  path = "module433.tf"
  if_exists = "overwrite_terragrunt"
  contents = <<EOF
resource "null_resource" "module4" {

}
EOF
}


terraform {
  source = "github.com/HeverFarber/templates.git"
}
