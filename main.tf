#################################
##          Provider           ##
#################################

terraform {
  required_version = ">= 0.12.31"

  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = "~> 3.43.0"
    }
  }
}

provider "aws" {
    region     = var.region
    access_key = var.access_key
    secret_key = var.secret_key
}

################################
##         Variables          ##
################################

variable "region" {}
variable "access_key" {}
variable "secret_key" {}

variable "allocated" {
    description = "DB Size in GB"
    default = "20"
}

variable "max_allocated" {
    description = "Max Autogrow DB Size in GB"
    default = "100"
}

variable "engine_version" {
    description = "Version of the RDS Engine"
    default = "5.7"
}

variable "db_user" {
    description = "DB User"
    default = "admin"
}

variable "db_password" {
    description = "DB Password"
    sensitive = true
    default = ""
}

variable "apply_immediately" {
    description = "Apply Changes Immediately"
    default     = "true"
}

#################################
##           Resources         ##
#################################

resource "aws_db_instance" "default" {
  allocated_storage = var.allocated
  max_allocated_storage = var.max_allocated
  storage_type = "gp2"
  engine = "mysql"
  engine_version = var.engine_version
  instance_class = "db.t2.micro"
  name = var.db_name
  username = var.db_user
  password = var.db_password
  parameter_group_name = "default.mysql5.7"
  apply_immediately = var.apply_immediately
  final_snapshot_identifier = "mysql-backup"
  skip_final_snapshot = true
}
