
resource "null_resource" "null" {
}

variable "alon" {
  type = string
  description = "env variable exported from deployment"
  default = "default@domain.com"
}

output "custom_flow_tf_var" {
  value = var.alon
}
