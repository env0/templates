resource "null_resource" "null-object" {
  count = var.object.list[0].count
}

resource "null_resource" "null-list" {
  count = var.list[0].count
}