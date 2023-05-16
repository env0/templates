resource "null_resource" "null" {
}

output "frontend_output" {
  value = "test"
}

output "inherited_output" {
    value = var.backend_output
}