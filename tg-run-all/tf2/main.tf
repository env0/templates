resource "null_resource" "tomer3" {
    count = 2
}

output "tf2_output" {
  value = var.tomer
}
