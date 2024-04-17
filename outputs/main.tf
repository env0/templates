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
  value = "100"
}

output "bool" {
  value = true

}

output "str" {
  value = "my name is shubi subi"
}

output "sens" {
  value     = "my name is shubi subi"
  sensitive = true
}

output "obj" {
  value = {
    key = "shubham"
  }

}

output "list" {
  value = [ "shubham", "subi" ]
}

output "print" {
  value = {
    obj = var.obj_var
    list = var.list_var
    str  = var.str_var
    bool = var.bool_var
    num  = var.number_var
    sens = var.sens_var
  }
}
