module "acme-vpc" {
  source  = "terraform-aws-modules/vpc/aws"
  version = "~> 3.1.0"

  name = var.name
  cidr = var.cidr

  enable_nat_gateway = var.enable_nat_gateway
  single_nat_gateway = true
  one_nat_gateway_per_az = false


  azs             = ["${var.region}a", "${var.region}b"]
  private_subnets = var.private_subnets
  public_subnets  = var.public_subnets
}