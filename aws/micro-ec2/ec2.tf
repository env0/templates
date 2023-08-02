provider "aws" {
  region  = "us-east-1"
}

resource "aws_instance" "example_server" {
  ami           = "ami-026de66f9819e675d"
  instance_type = "t3.nano"

  tags = {
    Name = "Sag"
  }
}
