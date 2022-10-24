resource "null_resource" "null" {
}

variable "empty_object_var" {
  type    = "object"
  default = {}
}
