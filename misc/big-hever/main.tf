variable "length" {
  description = "length of string"
}

resource "random_string" "random" {
  length           = var.length
}

resource "null_resource" "big" {
  triggers = {
    random = random_string.random.result
  }
}