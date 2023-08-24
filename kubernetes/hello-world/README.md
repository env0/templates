# Kubernetes Hello World

Create a simple k8s namespace resource with a dynamic name using [env0 custom flow](https://docs.env0.com/docs/custom-flows).

### Connect to your K8s cluster in env0
In order to apply this resource as an env0 [K8s template](https://docs.env0.com/docs/k8s), you'll have to first connect to your cluster in env0. 
It can be easily done by following our [Kubernetes integration guide](https://docs.env0.com/docs/connect-your-cloud-account#kubernetes). 

### Getting the namespace name from env0
The name of the created namespace will be taken from the env0 environment variable $ENV0_K8S_NAMESPACE. You can set it in the `Namespace` input when creating an environment.