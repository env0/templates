provider "aws" {
  version = "~> 4.0"
  region  = "us-east-1"
}

terraform {
  required_version = ">= 0.13"
}

variable "user" {
  type    = string
  default = "env0"
}

locals {
  index_html = replace(file("${path.module}/index.template.html"), "!!!USER!!!", var.user)
}
