resource "null_resource" "null" {
}

variable "email" {
  type = string
  description = "env variable exported in env0.yml"
}

variable "user" {
  type = string
  description = "env variable that contains a whitespace in the value, exported in env0.yml"
}

output "custom_flow_tf_var" {
  value = var.email
}

output "custom_flow_tf_var_with_whitespace" {
  value = var.user
}
