
resource "helm_release" "heml" {
  name = "my-helm-release"
  values = [
    "image:",
    "  repository: nginx",
    "  tag: 1.16.0",
    "  pullPolicy: IfNotPresent"
  ]
  chart     = "./myetc.tar.gz"
  namespace = "default"
}