resource "null_resource" "example" {
  triggers = {
    timestamp = timestamp()
  }

  provisioner "local-exec" {
    command = "echo 'Hello, Terraform!'"
  }

  provisioner "local-exec" {
    when    = destroy
    command = "echo 'Terraform is destroying the resources.'"
  }
}
