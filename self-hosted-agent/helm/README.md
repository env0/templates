<!-- BEGINNING OF PRE-COMMIT-TERRAFORM DOCS HOOK -->
## Requirements

| Name | Version |
|------|---------|
| terraform | ~> 1.0 |
| aws | ~> 3.64.2 |
| helm | 2.3.0 |
| kubernetes | ~> 2.6.1 |

## Providers

| Name | Version |
|------|---------|
| aws | ~> 3.64.2 |
| helm | 2.3.0 |
| kubernetes | ~> 2.6.1 |

## Inputs

| Name | Description | Type | Default | Required |
|------|-------------|------|---------|:--------:|
| cluster | The EKS cluster to apply this configuration to | `string` | n/a | yes |
| debug | Enable verbose output | `bool` | `false` | no |
| namespace | The Kubernetes namespace scope of the requests | `string` | `"env0-keda"` | no |
| wait | Whether or not Helm should wait until all Pods, PVCs, Services, and minimum number of Pods of a Deployment, StatefulSet, or ReplicaSet are in a ready state before marking the release as successful | `bool` | `true` | no |

## Outputs

No output.

<!-- END OF PRE-COMMIT-TERRAFORM DOCS HOOK -->
