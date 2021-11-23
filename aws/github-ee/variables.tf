variable "aws_default_region" {
  default = "us-east-1"
}

variable "github_ami" {
  description = "The AMI of the github instance"
  default = "ami-05257abb99ee9bf3a"
}

variable "instance_type" {
  description = "EC2 machine type"
  default = "r5.xlarge"
}

variable "vpc_id" {
  description = "The vpc id for this instance"
}

variable "aws_route53_zone_id" {
  description = "Zone id for route 53 defaults to dev's"
}