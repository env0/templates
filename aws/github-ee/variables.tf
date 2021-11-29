variable "aws_default_region" {
  default = "us-east-1"
}

variable "github_ami" {
  description = "The AMI of the github instance"
}

variable "instance_type" {
  description = "EC2 machine type"
  default = "r3.large"
}

variable "vpc_id" {
  description = "The vpc id for this instance"
}

variable "aws_route53_zone_id" {
  description = "Zone id for route 53 defaults to dev's"
}

variable "dns_name" {
  description = "dns for github ee"
}

variable "cidr_block" {
  description = "VPC subnet for github ee"
}

variable "availability_zone" {
  description = "Availability zone for ec2"
  default = "us-east-1a"
}

variable "gh_ee_version" {
  description = "prefix"
}
