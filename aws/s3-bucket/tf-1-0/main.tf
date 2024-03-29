terraform {
  required_version = "1.0.0"
}

module "s3" {
  source = "../s3/"
}

output "s3-url" {
  value = module.s3.url
}
