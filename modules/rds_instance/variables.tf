variable "environment" {
  description = "The environment for which the RDS instance is provisioned"
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

variable "db_instance_class" {
  description = "The RDS instance class"
  type        = map
}

variable "db_allocated_storage" {
  description = "The allocated storage for RDS instances"
  type        = map
}

variable "subnet_ids" {
  description = "The list of subnet IDs for the RDS instance"
  type        = list(string)
}
