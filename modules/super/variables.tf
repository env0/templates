variable "bucket_name" {}
variable "service_roles" {
  type = map(object({ name : string, arn : string }))
}
variable "expiration_days" {
  default = 0
}
variable "param_for_bucket_name" {
  default = ""
}

variable "kms_deletion_window_in_days" {
  default = 30
}
variable "tags" {
  type    = map(string)
  default = {}
}
variable "kms_key_description" {
  default = "victor s3 customer managed key"
}

variable "bucket_policy_override" {
  type = string
  default = null
}

