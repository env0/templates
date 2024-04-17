variable "oidc_token" {
  type = string
}

resource "null_resource" "null-resource" {

  triggers = {
    timestamp = "${timestamp()}"
  }

  provisioner "local-exec" {
    command = "echo oidc_token: ${var.oidc_token}"
  }
}
