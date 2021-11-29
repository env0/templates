data "aws_ip_ranges" "ec2_instance_connect_ips" {
  services = ["ec2_instance_connect"]
}

resource "aws_security_group" "github_ee_security_group" {
  name   = "github-ee-${var.gh_ee_version}-sg"
  vpc_id = var.vpc_id

  ingress {
    description = "Git over SSH access. Clone, fetch, and push operations to public/private repositories supported."
    protocol    = "tcp"
    from_port   = 22
    to_port     = 22
    cidr_blocks      = ["0.0.0.0/0"]
  }

  ingress {
    description = "Simple Git protocol port. Clone and fetch operations to public repositories only"
    protocol    = "tcp"
    from_port   = 9418
    to_port     = 9418
    cidr_blocks      = ["0.0.0.0/0"]
  }

  ingress {
    description = "Web application and Git over HTTP access."
    protocol    = "tcp"
    from_port   = 80
    to_port     = 80
    cidr_blocks      = ["0.0.0.0/0"]
  }

  ingress {
    description = "Web application and Git over HTTPS access."
    protocol    = "tcp"
    from_port   = 443
    to_port     = 443
    cidr_blocks      = ["0.0.0.0/0"]
  }

  ingress {
    description = "Plain-text web based Management Console. Not required unless SSL is disabled manually."
    protocol    = "tcp"
    from_port   = 8080
    to_port     = 8080
    cidr_blocks      = ["0.0.0.0/0"]
  }

  ingress {
    description = "Secure web based Management Console. Required for basic installation and configuration."
    protocol    = "tcp"
    from_port   = 8443
    to_port     = 8443
    cidr_blocks      = ["0.0.0.0/0"]
  }

  // This is for enabling ec2_instance_connect for this instance
  // We are taking the IPs from AWS to allow them to access SSH on port 22
  ingress {
    protocol    = "tcp"
    from_port   = 122
    to_port     = 122
    cidr_blocks = data.aws_ip_ranges.ec2_instance_connect_ips.cidr_blocks
  }
    
  ingress {
    protocol    = "tcp"
    from_port   = 122
    to_port     = 122
    cidr_blocks = ["0.0.0.0/0"]
  }

  egress {
    protocol    = -1
    from_port   = 0
    to_port     = 0
    cidr_blocks = ["0.0.0.0/0"]
  }
}
