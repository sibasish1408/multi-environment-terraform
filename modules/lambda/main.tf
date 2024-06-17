resource "aws_lambda_function" "hello_world" {
  function_name = "${var.environment}_hello_world"
  handler       = "index.handler"
  runtime       = "nodejs14.x"
  role          = aws_iam_role.lambda_exec.arn

  filename      = "lambda_function_payload.zip"
  source_code_hash = filebase64sha256("lambda_function_payload.zip")

  environment {
    variables = {
      DB_ENDPOINT = module.rds_instance.endpoint
    }
  }

  tags = {
    Name = "${var.environment}_hello_world"
  }
}

resource "aws_lambda_permission" "allow_api_gateway" {
  statement_id  = "AllowAPIGatewayInvoke"
  action        = "lambda:InvokeFunction"
  function_name = aws_lambda_function.hello_world.function_name
  principal     = "apigateway.amazonaws.com"
}

resource "aws_api_gateway_rest_api" "api" {
  name        = "${var.environment}_api"
  description = "API for ${var.environment} environment"
}

resource "aws_api_gateway_resource" "resource" {
  rest_api_id = aws_api_gateway_rest_api.api.id
  parent_id   = aws_api_gateway_rest_api.api.root_resource_id
  path_part   = "hello"
}

resource "aws_api_gateway_method" "method" {
  rest_api_id   = aws_api_gateway_rest_api.api.id
  resource_id   = aws_api_gateway_resource.resource.id
  http_method   = "GET"
  authorization = "NONE"
}

resource "aws_api_gateway_integration" "integration" {
  rest_api_id = aws_api_gateway_rest_api.api.id
  resource_id = aws_api_gateway_resource.resource.id
  http_method = aws_api_gateway_method.method.http_method
  type        = "AWS_PROXY"
  integration_http_method = "POST"
  uri         = aws_lambda_function.hello_world.invoke_arn
}

resource "aws_api_gateway_deployment" "deployment" {
  depends_on = [aws_api_gateway_integration.integration]
  rest_api_id = aws_api_gateway_rest_api.api.id
  stage_name  = "prod"
}

output "url" {
  value = aws_api_gateway_deployment.deployment.invoke_url
}
