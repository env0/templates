terraform {
  backend "s3" {
  }
}

provider "aws" {}

provider "helm" {
  debug = var.debug

  kubernetes {
    cluster_ca_certificate = module.cluster.certificate_authority

    exec {
      api_version = "client.authentication.k8s.io/v1alpha1"
      args        = ["eks", "get-token", "--cluster-name", module.cluster.name]
      command     = "aws"
    }

    host = module.cluster.endpoint
  }
}

provider "kubernetes" {
  cluster_ca_certificate = module.cluster.certificate_authority

  exec {
    api_version = "client.authentication.k8s.io/v1alpha1"
    args        = ["eks", "get-token", "--cluster-name", module.cluster.name]
    command     = "aws"
  }

  host = module.cluster.endpoint
}

locals {
  account_id = data.aws_caller_identity.this.account_id
  region     = data.aws_region.this.name
}

data "aws_region" "this" {}

data "aws_caller_identity" "this" {}

data "aws_iam_policy_document" "this" {
  statement {
    actions   = ["sts:AssumeRole"]
    effect    = "Allow"
    resources = ["arn:aws:iam::${local.account_id}:role/ServiceRoleForEnv0*"]
  }

  statement {
    actions = ["secretsmanager:GetSecretValue"]
    effect  = "Allow"
    resources = formatlist(
      "arn:aws:secretsmanager:${local.region}:${local.account_id}:secret/env0/%s/*",
      [
        "environments",
        "projects",
        "templates"
      ]
    )
  }

  version = "2012-10-17"
}

data "aws_efs_file_system" "this" {
  tags = {
    Name = "efs-csi"
  }
}

module "cluster" {
  source = "github.com/mongodb-ansible-roles/terraform-aws-eks-readonly?ref=v1.2.0"

  cluster_name = var.cluster
}

resource "aws_iam_user" "this" {
  name = "env0-agent"
}

resource "aws_iam_access_key" "this" {
  user = aws_iam_user.this.name
}

resource "aws_iam_user_policy" "this" {
  policy = data.aws_iam_policy_document.this.json
  user   = aws_iam_user.this.name
}

resource "kubernetes_storage_class" "this" {
  metadata {
    name = "env0-state-sc"
  }

  parameters = {
    directoryPerms   = "700"
    fileSystemId     = data.aws_efs_file_system.this.file_system_id
    provisioningMode = "efs-ap"
  }

  reclaim_policy      = "Retain"
  storage_provisioner = "efs.csi.aws.com"
}

resource "helm_release" "keda" {
  chart            = "keda"
  create_namespace = true
  name             = "env0-keda"
  namespace        = var.namespace
  repository       = "https://env0.github.io/self-hosted"

  set {
    name  = "podSecurityContext.fsGroup"
    value = 65534
  }

  set {
    name  = "securityContext.runAsNonRoot"
    value = true
  }

  set {
    name  = "securityContext.runAsUser"
    value = 65534
  }

  timeout = 600
  version = "v2.4.0"
}

resource "helm_release" "agent" {
  chart            = "env0-agent"
  create_namespace = true
  name             = "env0-agent"
  namespace        = helm_release.keda.metadata[0].namespace
  repository       = "https://env0.github.io/self-hosted"

  set {
    name  = "assumerKeyIdEncoded"
    value = base64encode(aws_iam_access_key.this.id)
  }

  set_sensitive {
    name  = "assumerSecretEncoded"
    value = base64encode(aws_iam_access_key.this.secret)
  }

  set {
    name  = "customerAwsAccessKeyIdEncoded"
    value = base64encode(aws_iam_access_key.this.id)
  }

  set_sensitive {
    name  = "customerAwsSecretAccessKeyEncoded"
    value = base64encode(aws_iam_access_key.this.secret)
  }

  set {
    name  = "region"
    value = data.aws_region.this.name
  }

  timeout = 600
  values  = [file("${path.module}/values.yaml")]
  version = "v2.0.46"

  depends_on = [kubernetes_storage_class.this]
}
