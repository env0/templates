provider "aws" {
  region = "us-east-1"
}

resource "aws_instance" "test-instance" {
  ami = "ami-0c654c3ab463d22f6"
  instance_type = "t2.micro"
}
