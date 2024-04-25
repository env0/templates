resource "null_resource" "name" {
  count = 1
}

variable "name" {
  type = string
  default = "default"
}

output "name" {
  value = var.name
}