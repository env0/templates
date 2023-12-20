terraform {
  cloud {
    hostname     = "backend-dev.api.dev.env0.com"
    organization = "bd12a04a-b051-4f51-9a8a-8a32ac198802.6b1b0897-5322-48cd-98b7-5e11766f54c8"
    workspaces {
      name = "product-demo"
    }
  }

  required_version = "1.5.7"

}

resource "null_resource" "null" {
  count = 5
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
