resource "null_resource" "null" {
  
}

variable "counter" {
  type = number
  default = 0
}

output "deployment_counter" {
  value = var.counter + 1
}