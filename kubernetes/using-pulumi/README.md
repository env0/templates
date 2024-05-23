# Kubernetes Using Pulumi

Create a k8s pod resource with [Pulumi k8s provider](https://www.pulumi.com/registry/packages/kubernetes/).

### Connect to your K8s cluster in env0
In order to apply this resource as an env0 [Pulumi template](https://docs.env0.com/docs/pulumi), you'll have to first connect to your cluster in env0.
It can be easily done by following our [Kubernetes integration guide](https://docs.env0.com/docs/connect-your-cloud-account#kubernetes).

### Setting the k8s provider
When you use our [Kubernetes integration](https://docs.env0.com/docs/connect-your-cloud-account#kubernetes) we create a kubeconfig file for you in the default location `~/.kube/config`.
Pulumi, by default, will look for a kubeconfig file in that location when using the Pulumi provider configuration:

```typescript
let provider = new k8s.Provider("k8s-provider");
```