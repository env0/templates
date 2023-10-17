terraform {
  backend "remote" {
    hostname     = "backend-pr13410.api.dev.env0.com"
    organization = "3bc8977f-d28c-450c-8264-986ea14a9dfa.01aaca09-2ff7-4639-8071-cf53f61abf5d"
    workspaces {
      name = "terratag"
    }
  }
}

resource "null_resource" "null" {
  count = 3
}


# resource "aws_s3_bucket" "example" {
#   bucket = "my-tf-test-bucket"

#   tags = {
#     Test = "yes"
#   }
# }
