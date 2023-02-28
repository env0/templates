variable "counter" {
  type = number
  default = 4
}

resource "null_resource" "null" {
  count = var.counter
}

