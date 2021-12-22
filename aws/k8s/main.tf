locals {
  namespace = "env0-keda" # namespace between the two installations must match as CRDs are scoped to namespace
}

provider "aws" {
  region = var.region
}

data "aws_eks_cluster" "cluster" {
  name = module.my-cluster.cluster_id
}

data "aws_eks_cluster_auth" "cluster" {
  name = module.my-cluster.cluster_id
}

provider "kubernetes" {
  host                   = data.aws_eks_cluster.cluster.endpoint
  cluster_ca_certificate = base64decode(data.aws_eks_cluster.cluster.certificate_authority[0].data)
  token                  = data.aws_eks_cluster_auth.cluster.token
}

provider "kubectl" {
  host                   = data.aws_eks_cluster.cluster.endpoint
  cluster_ca_certificate = base64decode(data.aws_eks_cluster.cluster.certificate_authority[0].data)
  token                  = data.aws_eks_cluster_auth.cluster.token
  load_config_file       = false
}

provider "helm" {
  kubernetes {
    host                   = data.aws_eks_cluster.cluster.endpoint
    cluster_ca_certificate = base64decode(data.aws_eks_cluster.cluster.certificate_authority.0.data)
    exec {
      api_version = "client.authentication.k8s.io/v1alpha1"
      args        = ["eks", "get-token", "--cluster-name", data.aws_eks_cluster.cluster.name]
      command     = "aws"
    }
  }
}

module "my-cluster" {
  source = "github.com/env0/k8s-modules//aws?ref=feat-add-aws-modules"

  region       = var.region
  cluster_name = var.cluster_name
}

resource "helm_release" "keda" {
  depends_on = [module.my-cluster]

  repository       = "https://env0.github.io/self-hosted"
  chart            = "keda"
  name             = "env0-keda"
  version          = "2.4.0"
  namespace        = local.namespace
  create_namespace = true
  timeout          = 600
}

resource "helm_release" "agent" {
  depends_on       = [module.my-cluster, helm_release.keda]
  name             = "env0-agent"
  namespace        = local.namespace
  create_namespace = true
  repository       = "https://env0.github.io/self-hosted"
  chart            = "env0-agent"
  timeout          = 600
  values           = [
    yamlencode(merge(yamldecode(var.env0_values), yamldecode(var.customer_values)))
  ]
}