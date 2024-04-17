resource "null_resource" "null" {
  provisioner "local-exec" {
    command = "echo \"from env cf: ${ENV0_ENVIRONMENT_ID}\""
  }
}
