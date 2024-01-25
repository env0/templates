resource "null_resource" "a" {}
resource "null_resource" "b" {}
resource "null_resource" "c" {
  count = var.n_resources
  depends_on = [ null_resource.a ]
}
