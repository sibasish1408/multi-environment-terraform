variable "region" {
  description = "The AWS region to deploy resources in"
  type        = string
}

variable "db_username" {
  description = "The database admin username"
  type        = string
}

variable "db_password" {
  description = "The database admin password"
  type        = string
}

variable "environment" {
  description = "Environment to deploy"
  type        = string
}

variable "db_instance_class" {
  description = "The RDS instance class"
  type        = map
  default     = {
    dev     = "db.t3.micro"
    testing = "db.t3.micro"
    staging = "db.t3.micro"
    prod    = "db.m5.xlarge"
  }
}

variable "db_allocated_storage" {
  description = "The allocated storage for RDS instances"
  type        = map
  default     = {
    dev     = 5
    testing = 5
    staging = 5
    prod    = 20
  }
}
