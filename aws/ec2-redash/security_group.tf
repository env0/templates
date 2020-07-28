resource "aws_security_group" "redash-sg" {
  name        = "redash-sg"
  description = "Redash Seciurity group"
  vpc_id      = aws_vpc.redash-vpc.id

  egress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }

  tags = {
    "Name" = "redash-sg"
    "CreatedBy" = "env0"
  }
}

resource "aws_security_group_rule" "redash-group-rule-for-https" {
  description              = "Allow HTTPS connection to the redash instance"
  from_port                = 443
  protocol                 = "tcp"
  security_group_id        = aws_security_group.redash-sg.id
  to_port                  = 443
  type                     = "ingress"
  cidr_blocks              = ["0.0.0.0/0"]
}

resource "aws_security_group_rule" "redash-group-rule-for-http" {
  description              = "Allow HTTP connection to the redash instance"
  from_port                = 80
  protocol                 = "tcp"
  security_group_id        = aws_security_group.redash-sg.id
  to_port                  = 80
  type                     = "ingress"
  cidr_blocks              = ["0.0.0.0/0"]
}

resource "aws_security_group_rule" "redash-group-rule-for-ssh" {
  description              = "Allow SSH connection to the redash instance"
  from_port                = 22
  protocol                 = "tcp"
  security_group_id        = aws_security_group.redash-sg.id
  to_port                  = 22
  type                     = "ingress"
  cidr_blocks              = ["0.0.0.0/0"]
}
