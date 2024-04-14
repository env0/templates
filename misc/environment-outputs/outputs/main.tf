resource "null_resource" "null" {
}

output "not_sensitive_output" {
  value = "not sensitive"
}


output "sensitive_output" {
  value = "sensitive"
  sensitive = true
}
