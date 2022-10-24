variable "rds_password_secret_name" {}
variable "rds_username" {}
variable "rds_host" {}
variable "rds_database" {}

data "aws_secretsmanager_secret" "db_password_secret" {
  name = var.rds_password_secret_name
  # depends_on = [module.kms_key]
}

data "aws_secretsmanager_secret_version" "db_password_secret_version" {
  secret_id = data.aws_secretsmanager_secret.db_password_secret.id
  # depends_on = [module.kms_key]
}

provider "postgresql" {
  host            = var.rds_host
  superuser       = false
  port            = "5432"
  database        = var.rds_database
  username        = var.rds_username
  password        = data.aws_secretsmanager_secret_version.db_password_secret_version.secret_string
  sslmode         = "require"
  connect_timeout = 15
}

resource "postgresql_role" "ems_db_full_access_role" {
  name            = "test_role_full_access"
  login           = false
  create_database = true
}

terraform {
  required_providers {
    postgresql = {
      source  = "cyrilgdn/postgresql"
      version = ">= 1.15.0"
    }
  }
}
