terraform {
  required_version = ">= 1.2.0, < 2.0.0"

}
resource "null_resource" "null" {
  provisioner "local-exec" {
    command = 'echo "from env cf: ${ENV0_ENVIRONMENT_ID}"'
  }
}
