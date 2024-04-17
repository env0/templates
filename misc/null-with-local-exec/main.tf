resource "null_resource" "null-resource" {

  triggers = {
    timestamp = "${timestamp()}"
  }

  provisioner "local-exec" {
    command = "echo hello"
  }
}
