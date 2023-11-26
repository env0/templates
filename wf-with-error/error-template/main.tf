provider "aws" {
  region = "us-west-2"
}

resource "aws_instance" "example" {
  ami           = "ami-12345678" # Invalid AMI ID to simulate an error
  instance_type = "t2.micro"
}
