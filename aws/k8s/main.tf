provider "aws" {
  region = var.region
}

module "my-cluster" {
  source = "git::github.com:env0/k8s-modules.git//aws?ref=feat-add-aws-modules"

  cluster_name = var.cluster_name
}