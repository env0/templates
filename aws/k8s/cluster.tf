module "my-cluster" {
  source = "github.com/env0/k8s-modules//aws?ref=chore-check-csi-directory-permission"

  region       = var.region
  cluster_name = var.cluster_name
}
