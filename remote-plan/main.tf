terraform {
  cloud {
    # hostname     = "backend-pr14022.api.dev.env0.com"
    # organization = "be029f7d-9089-4d20-8c7d-c04f54ff6149.5df4877e-1ab8-4ea4-9a44-2f30efec9a0a"
    hostname     = "backend-dev.api.dev.env0.com"
    organization = "bd12a04a-b051-4f51-9a8a-8a32ac198802.6b1b0897-5322-48cd-98b7-5e11766f54c8"
    # hostname     = "backend.api.env0.com"
    # organization = "e3900e8f-002c-4689-8004-bbab8f269ab9.b9d0773a-96c7-4d67-be3d-2b2521381d92"
    # organization = "tomer123"
    workspaces {
      name = "qa-party"
    }
  }

  required_version = "1.5.7"

}

resource "null_resource" "null" {
  count = 3
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
