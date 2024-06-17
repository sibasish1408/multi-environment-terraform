terraform {
  backend "local" {
    path = "./terraform.tfstate"
  }
}

provider "aws" {
  region = var.region
}

module "rds_instance" {
  source             = "../../modules/rds_instance"
  environment        = "dev"
  db_username        = var.db_username
  db_password        = var.db_password
  db_instance_class  = "db.t3.micro"
  db_allocated_storage = 5
  subnet_ids         = var.subnet_ids
}

module "lambda" {
  source       = "../../modules/lambda"
  environment  = "dev"
  db_endpoint  = module.rds_instance.endpoint
}
