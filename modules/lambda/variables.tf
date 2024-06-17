variable "environment" {
  description = "The environment for which the Lambda function is deployed"
  type        = string
}

variable "db_endpoint" {
  description = "The RDS endpoint for the Lambda function"
  type        = string
}
