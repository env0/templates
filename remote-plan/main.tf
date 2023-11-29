# terraform {
#   backend "remote" {
#     # hostname     = "backend-pr13908.api.dev.env0.com"
#     # organization = "f5f63028-62dc-4273-910a-2f4edb310896.81609940-4103-4817-bb6a-23031487f832"
#     # hostname     = "backend-dev.api.dev.env0.com"
#     # organization = "bd12a04a-b051-4f51-9a8a-8a32ac198802.6b1b0897-5322-48cd-98b7-5e11766f54c8"
#     # hostname     = "backend.api.env0.com"
#     # organization = "e3900e8f-002c-4689-8004-bbab8f269ab9.b9d0773a-96c7-4d67-be3d-2b2521381d92"
#     # organization = "tomer123"
#     workspaces {
#       name = "cloud-test2"
#     }
#   }

#   # required_version = "~> 1.0.0"

# }

resource "null_resource" "null" {
  count = 2
}
# provider "aws" {
#   region = "us-west-2"
# }

# resource "aws_instance" "example" {
#   ami           = "ami-12345678" # Invalid AMI ID to simulate an error
#   instance_type = "t2.micro"
# }
# resource "aws_s3_bucket" "example" {
#   bucket = "my-tf-test-bucket"

#   tags = {
#     Test = "yes"
#   }
# }
