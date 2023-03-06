data "aws_eks_cluster" "cluster" {
  name = var.cluster_name
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

resource "helm_release" "vault_release" {
  name             = "self-hosted-vault"
  namespace        = "self-hosted-vault"
  repository       = "https://helm.releases.hashicorp.com"
  chart            = "vault"
  create_namespace = true

  // Configuration reference in
  // https://www.vaultproject.io/docs/platform/k8s/helm/configuration
  values = [
    "${file("vault-config.yaml")}"
  ]

  set {
    name  = "server.dev.devRootToken"
    value = var.dev_root_token
  }
}
