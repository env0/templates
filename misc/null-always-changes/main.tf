resource "null_resource" "null-resource" {

  triggers = {
    timestamp = "${timestamp()}"
  }
}
