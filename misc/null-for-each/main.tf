resource "null_resource" "null2" {
  for_each = toset(["aaa.yariv", "bbb", "ccc"])
}