resource "null_resource" "null" {
      triggers = {
    null_instance_ids = var.instance_type
  }
}
resource "null_resource" "null1" {
}
resource "null_resource" "null2" {
}
