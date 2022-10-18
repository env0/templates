# ------------------------------------------------------------------------------
# Management
# ------------------------------------------------------------------------------

variable "environment" {
  description = "The execution environment: [org|devops|dev|stag|prod]"
  type        = string
  default     = "CHANGEME"
  nullable    = false
  validation {
    condition     = var.environment != "CHANGEME" && contains(["org", "devops", "dev", "stag", "prod"], var.environment) && lower(var.environment) == var.environment && !can(regex(" ", var.environment))
    error_message = "The variable 'environment' must match the short form references as defined here: <link to docs>"
  }
}

variable "department" {
  description = "The department responsible for the resource. (lowercase)"
  type        = string
  nullable    = false
  default     = "CHANGEME"
  validation {
    condition     = var.department != "CHANGEME" && lower(var.department) == var.department && !can(regex(" ", var.department))
    error_message = "Must be lowercase and not contain spaces."
  }
}

variable "application" {
  description = "The application this resouce is is supporting. (lowercase)"
  type        = string
  nullable    = false
  default     = "infrastructure"
  validation {
    condition     = var.application != "CHANGEME" && lower(var.application) == var.application && !can(regex(" ", var.application))
    error_message = "Must be lowercase and not contain spaces."
  }
}

variable "orchestration" {
  description = "The repository for this infrastructure (IaC)"
  type        = string
  nullable    = false
  default     = "https://github.com/env0/templates/blob/master/aws/iam/env0-cost-estimation-role/"
}

variable "aws_region" {
  description = "The region in which to execute."
  type        = string
  nullable    = false
  default     = "CHANGEME"
  validation {
    condition     = var.aws_region != "CHANGEME" && !can(regex(" ", var.aws_region))
    error_message = "The variable 'aws_region' must be one of the operating regions as defined here: <link to docs>"
  }
}
