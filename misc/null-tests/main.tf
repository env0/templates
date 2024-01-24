resource "local_file" "test" {
  filename = "${path.module}/test.txt"
  content  = "Hello world!"
}

resource "time_sleep" "wait_30_seconds" {
  create_duration = "1s"
  destroy_duration = "2s"
}

resource "null_resource" "hever" {
  count = var.counter
  triggers = {
    test = "hever"
  }
}

variable "counter" {
    default = 0
}

variable "instances" {
  default = [{
    type = "t2.microsss"
  }]
}