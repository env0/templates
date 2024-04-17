resource "null_resource" "dunno" {
  count = 3

}

variable "number_var" {
  type = number
  default = 0
}

variable "bool_var" {
  type = bool
  default = false
}

variable "str_var" {
  type = string
  default = "default"
}

variable "sens_var" {
  type = string
  sensitive = true
  default = "not-sensitive"
}

variable "obj_var" {
  type = object({
    key = string
  })
  default = {
    key = "not-value"
  }

}

variable "list_var" {
  type = list(string)
  default = [ "value" ]
}


output "number" {
  value = 1
}

output "bool" {
  value = true

}

output "str" {
  value = "lalala"
}

output "sens" {
  value     = "sensitive"
  sensitive = true
}

output "obj" {
  value = {
    key = "value"
  }

}

output "list" {
  value = ["a", "b", "c"]
}

output "print" {
  value = {
    obj = var.obj_var
    list = var.list_var
    str  = var.str_var
    bool = var.bool_var
    num  = var.number_var
  }
}
