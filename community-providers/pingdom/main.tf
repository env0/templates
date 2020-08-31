terraform {
  required_version = ">= 0.11.0"
}

provider "pingdom" {
  user     = "user"
  password = "password"
  api_key  = "dummy"
}

resource "pingdom_team" "rd" {
  name = "R&D"
}

resource "pingdom_user" "manager" {
  username = "Manager Cohen"
}

resource "pingdom_contact" "manager_contact" {
  user_id        = pingdom_user.manager.id
  email          = "john@doe.com"
  severity_level = "HIGH"
}
