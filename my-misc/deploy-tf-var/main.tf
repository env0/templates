resource "null_resource" "null" {
}

varaible "doesntexists" {
  type = string
  description = "a var to make the deployment fail"
}

variable "SOMETHING" {
  type = string
  description = "env variable from deployment"
}

output "custom_flow_tf_var" {
  value = var.SOMETHING
}
