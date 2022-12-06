
resource "helm_release" "vault_release" {
  name             = "self-hosted-vault"
  namespace        = "self-hosted-vault"
  repository       = "https://helm.releases.hashicorp.com"
  chart            = "vault"
  create_namespace = true
  version          = "0.21.0"

  // Configuration reference in
  // https://www.vaultproject.io/docs/platform/k8s/helm/configuration
  values = [
    "${file("vault-config.yaml")}"
  ]

  # These additonal settings are merged with the values defined above
  # This is done to hide the postgresql database connection info
  # The secret is owned by the webgen3 devops team

  set {
    name  = "server.volumes[0].name"
    value = "userconfig-vault-storage-config"
  }

  set {
    name  = "server.volumes[0].secret.defaultMode"
    value = "420"
  }

  set {
    name  = "server.volumes[0].secret.secretName"
    value = "vault-storage-config"
  }

  set {
    name  = "server.volumeMounts[0].mountPath"
    value = "/vault/userconfig/vault-storage-config"
  }

  set {
    name  = "server.volumeMounts[0].name"
    value = "userconfig-vault-storage-config"
  }

  set {
    name  = "server.volumeMounts[0].readOnly"
    value = "true"
  }

  set {
    name  = "server.extraArgs"
    value = "-config=/vault/userconfig/vault-storage-config/config.hcl"
  }
}

locals {
  resource_list = yamldecode(file("postgres.yaml")).items
}

resource "kubectl_manifest" "postgres_manifest" {
  count     = length(local.resource_list)
  yaml_body = yamlencode(local.resource_list[count.index])
}
