resource "null_resource" "null" {
  provisioner "local-exec" {
    command = "printenv"
  }
}

resource "null_resource" "null3" {
  provisioner "local-exec" {
    command = "printenv"
  }
}