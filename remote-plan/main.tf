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
module "my-module" {
  source = "api-dev.dev.env0.com/bd12a04a-b051-4f51-9a8a-8a32ac198802/my-module/tomer"
  version = "1.1.0"
}
