resource "null_resource" "dunno" {
  count = 3

  triggers = {
    "1" = var.sens_var
  }
  

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
  value = var.number_var
}

output "bool" {
  value = var.bool_var

}

output "str" {
  value = var.str_var
}

output "sens" {
  value     = var.sens_var
  sensitive = true
}

output "obj" {
  value = var.obj_var

}

output "list" {
  value = var.list_var
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
