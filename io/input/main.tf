resource "null_resource" "name" {
  count = 1
}

variable "name" {
  type = string
  default = "kaka baleben"
  
}

output "name_out" {
  value = var.name
}
