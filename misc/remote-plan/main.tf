resource "null_resource" "branch2" {
  count = 2
}

output "tomerout" {
  value = var.tomer
}
