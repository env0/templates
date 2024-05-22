resource "null_resource" "null" {
  provisioner "local-exec" {
    command = "printenv"
  }
}

resource "null_resource" "null2" {
  provisioner "local-exec" {
    command = "printenv"
  }
}