terraform {
  cloud {
    hostname     = "backend-pr13949.api.dev.env0.com"
    organization = "87313781-6b8b-4ed3-9f26-fcf5096e5e62.1827e489-3b42-4ee9-928e-f430135c0108"
    # hostname     = "backend-dev.api.dev.env0.com"
    # organization = "bd12a04a-b051-4f51-9a8a-8a32ac198802.6b1b0897-5322-48cd-98b7-5e11766f54c8"
    # hostname     = "backend.api.env0.com"
    # organization = "e3900e8f-002c-4689-8004-bbab8f269ab9.b9d0773a-96c7-4d67-be3d-2b2521381d92"
    # organization = "tomer123"
    workspaces {
      name = "cloud-block-26738-53433839"
    }
  }

}

resource "null_resource" "null" {
  count = 6
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
