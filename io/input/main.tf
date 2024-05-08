resource "null_resource" "name" {
  count = 2
}

variable "message" {
  type = string
  default = "Nothing was Provided for me :)"
  
}

output "message_out" {
  value = var.message
}
