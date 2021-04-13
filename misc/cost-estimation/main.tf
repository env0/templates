provider "aws" {
  region                      = "us-east-1" # <<<<< Try changing this to eu-west-1 to compare the costs
  skip_credentials_validation = true
  skip_requesting_account_id  = true
}

variable "instance_type" {
  type = string
  default = "m5.4xlarge"
}

variable "volume_type" {
  type = string
  default = "io1"
}

variable "memory_size" {
  type = number
  default = 1024
}

resource "aws_instance" "web_app" {
  ami           = "ami-041ba027e6cfd5da6"
  instance_type = var.instance_type

  root_block_device {
    volume_size = 50
  }

  ebs_block_device {
    device_name = "my_data"
    volume_type = var.volume_type
    volume_size = 1000
    iops        = 800
  }
}

resource "aws_lambda_function" "hello_world" {
  function_name = "hello_world"
  role          = "arn:aws:lambda:us-east-1:account-id:resource-id"
  handler       = "exports.test"
  runtime       = "nodejs12.x"
  memory_size   = var.memory_size
}
