provider "aws" {
  region = "us-east-1" # Replace with your AWS region (ensure this AMI exists in your region)
}

# Security Group definition
resource "aws_security_group" "server-security-group" {
  name = "server-security-group"

  # Ingress rule to allow traffic from specific IPs on port 80 (HTTP)
  ingress {
    from_port = 80 # HTTP port
    to_port   = 80
    protocol  = "tcp"
    cidr_blocks = [
      "192.168.1.1/32", # IP 1
      "192.168.1.2/32", # IP 2
      "203.0.113.0/24", # IP range 3
    ]
  }

  # Ingress rule to allow traffic from specific IPs on port 443 (HTTPS)
  ingress {
    from_port = 443 # HTTPS port
    to_port   = 443
    protocol  = "tcp"
    cidr_blocks = [
      "192.168.1.1/32", # IP 1
      "203.0.113.0/24", # IP range 2
    ]
  }
}

# Generate the SSH key pair using Terraform (private and public key)
resource "tls_private_key" "ec2-private-key" {
  algorithm = "RSA"
  rsa_bits  = 2048
}

# Create the AWS key pair using the generated public key
resource "aws_key_pair" "ec2-key-pair" {
  key_name   = "ec2-key-pair"
  public_key = tls_private_key.ec2-private-key.public_key_openssh
}

# EC2 instance definition (using the provided AMI ID)
resource "aws_instance" "server-ec2-instance" {
  ami           = "ami-0453ec754f44f9a4a" # Specified AMI ID
  instance_type = "t2.micro"              # Cheapest instance type

  # Associate the EC2 instance with the security group created above
  security_groups = [aws_security_group.server-security-group.name]

  # Use the SSH key pair created above
  key_name = aws_key_pair.ec2-key-pair.key_name
}
