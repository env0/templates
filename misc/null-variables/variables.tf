variable "string" {
  type = string
}

variable "object" {
  type = object({ list: list(object({
    count = number
    value = string
  })) })

  default = { list = [{ count = 6, value = "ss" }]}
}

variable "list" {
  type = list(object({
    count  = number
    value = string
  }))

  default = []
}
