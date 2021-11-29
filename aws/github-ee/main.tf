resource "aws_subnet" "github_ee" {
  vpc_id                  = var.vpc_id
  cidr_block              = var.cidr_block
  map_public_ip_on_launch = true
  availability_zone       = var.availability_zone

  tags = {
      Name = "GithubEE-${var.gh_ee_version}"
  }
}

resource "aws_instance" "github_ee" {
  ami                         = var.github_ami
  key_name                    = aws_key_pair.github_ee_key.key_name
  instance_type               = var.instance_type
  vpc_security_group_ids      = [aws_security_group.github_ee_security_group.id]
  subnet_id                   = aws_subnet.github_ee.id
  associate_public_ip_address = true
  availability_zone           = var.availability_zone

  ebs_block_device {
    device_name = "/dev/xvdf"
    volume_size = 150
  }

  root_block_device {
    volume_size = 200
  }

  tags = {
    Name = "GithubEE-${var.gh_ee_version}"
  }
}



resource "aws_key_pair" "github_ee_key" {
  key_name   = "github-ee-${var.gh_ee_version}-ssh"
  public_key = tls_private_key.github_ee.public_key_openssh
}

resource "tls_private_key" "github_ee" {
  algorithm = "RSA"
  rsa_bits  = 4096
}
