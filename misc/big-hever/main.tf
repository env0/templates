variable "length" {
  description = "length of string"
}

resource "random_string" "random" {
  length           = var.length
}