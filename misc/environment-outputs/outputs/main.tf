resource "null_resource" "null" {
}

output "not sensitive output" {
  value = "not sensitive"
}


output "sensitive output" {
  value = "sensitive"
  sensitive = true
}
