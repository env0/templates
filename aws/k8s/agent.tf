resource "helm_release" "agent" {
  depends_on       = [module.my-cluster]
  name             = "env0-agent"
  namespace        = "env0-agent"
  create_namespace = true
  repository       = "https://env0.github.io/self-hosted"
  chart            = "env0-agent"
  timeout          = 600
  values           = [
    yamlencode(merge(var.env0_values, var.customer_values))
  ]
}
