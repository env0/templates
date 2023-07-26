resource "null_resource" "null" {
}

variable "SOMETHING" {
  type = string
  description = "env variable from deployment"
}

output "custom_flow_tf_var" {
  value = var.SOMETHING
}
