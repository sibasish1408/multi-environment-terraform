terraform {
  required_version = ">= 0.12"
  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = ">= 3.0"
    }
  }
}

provider "aws" {
  region = var.region
}

module "rds_instance" {
  source = "./modules/rds_instance"
  for_each = {
    "dev"      = "dev"
    "testing"  = "testing"
    "staging"  = "staging"
    "prod1"    = "prod"
    "prod2"    = "prod"
  }
  environment = each.value
}

module "lambda" {
  source = "./modules/lambda"
  for_each = {
    "dev"      = "dev"
    "testing"  = "testing"
    "staging"  = "staging"
    "prod1"    = "prod"
    "prod2"    = "prod"
  }
  environment = each.value
}
