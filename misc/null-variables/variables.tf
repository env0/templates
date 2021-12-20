variable "string" {
  type = string
}

variable "object" {
  type = object({ list: list(object({
    count = number
    value = string
  })) })
}

variable "list" {
  type = list(object({
    count  = number
    value = string
  }))

  default = []
}
