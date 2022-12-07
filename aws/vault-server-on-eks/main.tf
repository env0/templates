# Postgres Storgae Backend
data "kubectl_file_documents" "postgres_manifest" {
  content = file("postgres.yaml")
}

resource "kubectl_manifest" "postgres" {
  for_each  = data.kubectl_file_documents.postgres_manifest.manifests
  yaml_body = each.value
}

# Vault chart

resource "helm_release" "vault_release" {
  name             = "self-hosted-vault"
  namespace        = "self-hosted-vault"
  repository       = "https://helm.releases.hashicorp.com"
  chart            = "vault"
  create_namespace = true
  version          = "0.21.0"
  values = ["${file("vault-config.yaml")}"]

  depends_on = [kubectl_manifest.postgres]
}
