provider "aws" {
  region = "us-east-1"
}

resource "random_uuid" "uuid" { }

resource "tls_private_key" "private_key" {
  algorithm = "RSA"
  rsa_bits  = 4096
}

resource "aws_key_pair" "redash-key-pair" {
  key_name   = "redash-key-${random_uuid.uuid.result}"
  public_key = tls_private_key.private_key.public_key_openssh
}

resource "aws_instance" "test-instance" {
  ami = "ami-0c654c3ab463d22f6"
  instance_type = "t2.micro"
  key_name = aws_key_pair.redash-key-pair.key_name
}
