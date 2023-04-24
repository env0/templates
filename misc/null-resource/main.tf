variable "counter" {
  type = number
  default = 5
}

resource "null_resource" "null" {
  count = var.counter
}

