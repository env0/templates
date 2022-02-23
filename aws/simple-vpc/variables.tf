variable "name" {
  type    = string
  default = "env0-acme-vpc"
}

variable "cidr" {
  type    = string
  default = "10.0.0.0/16"
}

variable "private_subnets" {
  type    = list(any)
  default = ["10.0.1.0/24", "10.0.2.0/24"]
}

variable "public_subnets" {
  type    = list(any)
  default = ["10.0.10.0/24", "10.0.20.0/24"]
}

variable "enable_nat_gateway" {
  type    = bool
  default = false
}
variable "region" {
  type    = string
  default = "us-west-2"
}
