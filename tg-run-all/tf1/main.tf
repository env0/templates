resource "null_resource" "tomer1" {
    count = 1
}

output "tf1_output" {
  value = var.tomer
}
