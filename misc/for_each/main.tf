resource "null_resource" "null" {
  for_each = toSet(["null1", "null2"])
  
  triggers = {
    name = each.key
  }
}
