variable "counter" {
  type = number
  default = 1
}

resource "null_resource" "null" {
  count = var.counter
}

