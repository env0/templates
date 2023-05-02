variable "counter" {
  type = number
  default = 2
}

resource "null_resource" "null" {
  count = var.counter
}

