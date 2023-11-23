variable "test" {
  description = "test"
  type        = string
  default     = "default"
}

resource "null_resource" "null" {
}

output "vpc_id" {
  value = var.test
}
