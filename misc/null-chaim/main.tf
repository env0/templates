resource "null_resource" "a" {}
resource "null_resource" "b" {}
resource "null_resource" "c" {
  depends_on = [ null_resource.a ]
}
