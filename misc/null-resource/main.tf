variable "counter" {
  type = number
  default = 10
}

resource "null_resource" "null" {
  count = var.counter
}

