resource "null_resource" "null" {
    count = var.counter
}

variable "counter" {
  type = number
  default = 0
}

output "deployment_counter" {
  value = var.counter + 1
}

output "list_of_resources" {
  value = ["resource1", "resource2", "resource3"]
}