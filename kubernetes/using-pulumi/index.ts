import * as k8s from "@pulumi/kubernetes";

// Create a Kubernetes provider without specifying a kubeconfig
// It automatically uses the default kubeconfig on your machine
let provider = new k8s.Provider("k8s-provider");

// uses the created provider to create an Nginx pod
let pod = new k8s.core.v1.Pod("my-nginx", {
    metadata: {
        name: "my-nginx",
    },
    spec: {
        containers: [{
            name: "my-nginx",
            image: "nginx",
        }],
    },
}, { provider });

// Export the name of the Pod
export const podName = pod.metadata;