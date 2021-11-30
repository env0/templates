variable "cluster" {
  description = "The EKS cluster to apply this configuration to"
  type        = string
}

variable "debug" {
  default     = false
  description = "Enable verbose output"
  type        = bool
}

variable "namespace" {
  default     = "env0-keda"
  description = "The Kubernetes namespace scope of the requests"
  type        = string
}

variable "wait" {
  default     = true
  description = "Whether or not Helm should wait until all Pods, PVCs, Services, and minimum number of Pods of a Deployment, StatefulSet, or ReplicaSet are in a ready state before marking the release as successful"
  type        = bool
}
