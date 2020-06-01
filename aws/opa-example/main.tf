terraform {
  required_version = ">= 0.12"
}

provider "aws" {
  version = "~> 2.8"
  region = "us-east-1"
}

variable "ssh_cidr_block" {
  default = "0.0.0.0/0"
}

resource "aws_security_group" "allow_ssh" {
  name        = "my_security_group"
  description = "Allow SSH Trafic"

  ingress {
    description = "Incoming ssh"
    from_port   = 22
    to_port     = 22
    protocol    = "tcp"
    cidr_blocks = [var.ssh_cidr_block]
  }
}
