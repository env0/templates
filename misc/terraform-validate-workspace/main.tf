terraform {
  required_version = ">= 0.15.1"
}

resource "null_resource" "null" {
  count = terraform.workspace == "default" ? -1 : 0 # This is used to check that the workspace in "terraform validate" isn't the default one
}
