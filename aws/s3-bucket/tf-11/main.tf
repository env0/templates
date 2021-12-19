terraform {
  required_version = "~> 0.11.15"
}

module "s3" {
  source = "../s3/"
}

output "s3-url" {
  value = "${module.s3.url}"
}
