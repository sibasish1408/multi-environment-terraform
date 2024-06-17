terraform {
  backend "local" {
    path = "./terraform.tfstate"
  }
}

provider "aws" {
  region = var.region
}

module "rds_instance_prod1" {
  source             = "../../modules/rds_instance"
  environment        = "prod1"
  db_username        = var.db_username
  db_password        = var.db_password
  db_instance_class  = "db.m5.large"
  db_allocated_storage = 20
  subnet_ids         = var.subnet_ids
}

module "rds_instance_prod2" {
  source             = "../../modules/rds_instance"
  environment        = "prod2"
  db_username        = var.db_username
  db_password        = var.db_password
  db_instance_class  = "db.m5.large"
  db_allocated_storage = 20
  subnet_ids         = var.subnet_ids
}

module "lambda_prod1" {
  source       = "../../modules/lambda"
  environment  = "prod1"
  db_endpoint  = module.rds_instance_prod1.endpoint
}

module "lambda_prod2" {
  source       = "../../modules/lambda"
  environment  = "prod2"
  db_endpoint  = module.rds_instance_prod2.endpoint
}
