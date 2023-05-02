variable "counter" {
  type = number
  default = 7
}

resource "null_resource" "null" {
  count = var.counter
}

