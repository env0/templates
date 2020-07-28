#
# VPC Resources
#  * VPC
#  * Subnets
#  * Internet Gateway
#  * Route Table
#

resource "aws_vpc" "redash-vpc" {
  cidr_block = "10.0.0.0/16"
  enable_dns_hostnames = true
  enable_dns_support = true
}

resource "aws_subnet" "redash-subnet" {
  count = 1
  availability_zone = data.aws_availability_zones.available.names[count.index]
  cidr_block        = "10.0.${count.index}.0/24"
  vpc_id            = aws_vpc.redash-vpc.id
}

resource "aws_internet_gateway" "redash-ig" {
  vpc_id = aws_vpc.redash-vpc.id
}

resource "aws_route_table" "redash-rt" {
  vpc_id = aws_vpc.redash-vpc.id

  route {
    cidr_block = "0.0.0.0/0"
    gateway_id = aws_internet_gateway.redash-ig.id
  }
}

resource "aws_route_table_association" "redash-rt-association" {
  count = 1
  subnet_id      = aws_subnet.redash-subnet.*.id[count.index]
  route_table_id = aws_route_table.redash-rt.id
}
