generate "null_resource" {
  path = "tg-bbbb.main.tf"
  if_exists = "overwrite_terragrunt"
  contents = <<EOF
resource "null_resource" "null" {
  count = 2
}
EOF
}
