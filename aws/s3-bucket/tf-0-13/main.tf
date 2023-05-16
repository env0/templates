terraform {
  required_version = "~> 0.13.3"
}

module "s3" {
  source = "../s3/"
}

output "s3-url" {
  value = module.s3.url
}
