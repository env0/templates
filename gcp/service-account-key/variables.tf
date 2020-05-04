variable "account_id" {
  type = string
  description = "The id of the service account that will be created"
}

variable "account_display_name" {
  type = string
  description = "The display name of the service account that will be created"
}

variable "project" {
  type = string
  description = "The GCP project id"
}