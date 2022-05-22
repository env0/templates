
variable "email" {
  type = string
  description = "env variable exported in env0.yml"
  default = "default@domain.com"
}

variable "user" {
  type = string
  description = "env variable that contains a whitespace in the value, exported in env0.yml"
  default = "John Doe"
}

output "custom_flow_tf_var" {
  value = var.email
}

output "custom_flow_tf_var_with_whitespace" {
  value = var.user
}
#&& var.email == "default@domain.com"
data "assert_test" "assert_tf_values" {
    test = var.user == "John Doe"
    throw = "test failed!"
}

resource "null_resource" "null" {
  count = var.email == "default@domain.com" && var.user == "John Doe" ? 1 : 'FAIL'
}
