resource "null_resource" "a" {}
resource "null_resource" "b" {}
resource "null_resource" "c" {
  count = 100
  depends_on = [ null_resource.a ]
}
