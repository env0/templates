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

resource "helm_release" "example" {
  name             = "test-hello-world"
  namespace        = "test-hello-world"
  chart            = "https://cloudecho.github.io/charts/hello-0.1.2.tgz"
  create_namespace = true
}
