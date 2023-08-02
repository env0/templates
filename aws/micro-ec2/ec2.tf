resource "aws_instance" "example_server" {
  ami           = "ami-04e914639d0cca79a"
  instance_type = "t2.micro"
  region  = "us-east-1"

  tags = {
    Name = "Sag"
  }
}
