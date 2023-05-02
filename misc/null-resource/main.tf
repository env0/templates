variable "counter" {
  type = number
  default = 3
}

resource "null_resource" "null" {
  count = var.counter
}

