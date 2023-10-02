resource "null_resource" "null" {
}

variable "email" {
  type = string
  description = "env variable exported in env0.yml"
  default = "default@domain.com"
}

output "custom_flow_tf_var" {
  value = var.email
}
