resource "aws_subnet" "github_ee" {
  vpc_id                  = var.vpc_id
  cidr_block              = "172.31.150.0/24"
  map_public_ip_on_launch = true

  tags = {
      Name = "GithubEE"
  }
}

resource "aws_instance" "github_ee" {
  ami                         = var.github_ami
  key_name                    = aws_key_pair.github_ee_key.key_name
  instance_type               = var.instance_type
  vpc_security_group_ids      = [aws_security_group.github_ee_security_group.id]
  subnet_id                   = aws_subnet.github_ee.id
  associate_public_ip_address = true
  ebs_optimized               = true

  ebs_block_device {
    device_name = "/dev/xvdf"
    volume_size = 150
  }

  root_block_device {
    volume_size = 200
  }

  tags = {
    Name = "GithubEE"
  }
}

resource "aws_key_pair" "github_ee_key" {
  key_name   = "github-ee-ssh"
  public_key = tls_private_key.github_ee.public_key_openssh
}

resource "tls_private_key" "github_ee" {
  algorithm = "RSA"
  rsa_bits  = 4096
}
