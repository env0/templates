# Kubernetes Using Terraform

Create a k8s pod resource with [Terraform k8s provider](https://registry.terraform.io/providers/hashicorp/kubernetes/latest/docs).

### Connect to your K8s cluster in env0
In order to apply this resource as an env0 [Terraform template](https://docs.env0.com/docs/templates#terraform), you'll have to first connect to your cluster in env0.
It can be easily done by following our [Kubernetes integration guide](https://docs.env0.com/docs/connect-your-cloud-account#kubernetes).

### Setting the k8s provider
When you use our [Kubernetes integration](https://docs.env0.com/docs/connect-your-cloud-account#kubernetes) we create a kubeconfig file for you in the default location `~/.kube/config`.
You can easily use this kubeconfig file with the k8s provider by using the following Terraform provider configuration:

```hcl
provider "kubernetes" {
  config_path    = "~/.kube/config"
}
```