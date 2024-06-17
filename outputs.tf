output "rds_endpoints" {
  value = module.rds_instance.*.endpoint
}

output "lambda_urls" {
  value = module.lambda.*.url
}
