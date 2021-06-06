resource "null_resource" "null1" {
  depends_on = [null_resource.null2]
}

resource "null_resource" "null2" {
}
