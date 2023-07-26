resource "null_resource" "null" {
}

variable "alon" {
  type = string
}

output "custom_flow_tf_var" {
  value = var.alon
}
