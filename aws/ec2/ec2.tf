variable "aws_default_region" { default = "us-east-1"}
variable "instance_type" { default = "t2.small"}

provider "aws" {
  region = var.aws_default_region
}

resource "aws_instance" "test-instance" {
  ami = "ami-0c654c3ab463d22f6"
  instance_type = var.instance_type
}
