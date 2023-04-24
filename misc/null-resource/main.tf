variable "counter" {
  type = number
  default = 9
}

resource "null_resource" "null" {
  count = var.counter
}

