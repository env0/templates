variable "counter" {
  type = number
  default = 8
}

resource "null_resource" "null" {
  count = var.counter
}

