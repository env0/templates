variable "counter" {
  type = number
  default = 19
}

resource "null_resource" "null" {
  count = var.counter
}

