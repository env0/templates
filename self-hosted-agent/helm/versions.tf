terraform {
  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = "~> 3.64.2"
    }

    helm = {
      source  = "hashicorp/helm"
      version = "2.3.0"
    }

    kubernetes = {
      source  = "hashicorp/kubernetes"
      version = "~> 2.6.1"
    }
  }

  required_version = "~> 1.0"
}
