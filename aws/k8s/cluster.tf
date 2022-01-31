module "my-cluster" {
  source = "github.com/env0/k8s-modules//aws?ref=feat-Do-not-use-AWS-CLI-command"

  region       = var.region
  cluster_name = var.cluster_name
}