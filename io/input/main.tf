resource "null_resource" "name" {
  count = 3
}

variable "message" {
  type = string
  default = "Nothing was Provided for me :)"
  
}

variable "oops" {
  
}

output "message_out" {
  value = var.message
}
