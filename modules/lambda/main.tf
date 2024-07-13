variable "lambda_role_arn" {
  description = "The ARN of the IAM role for Lambda"
  type        = string
}

variable "db_endpoint" {
  description = "The endpoint of the RDS instance"
  type        = string
}

variable "db_username" {
  description = "The username for the RDS instance"
  type        = string
}

variable "db_password" {
  description = "The password for the RDS instance"
  type        = string
  sensitive   = true
}

variable "db_name" {
  description = "The name of the database"
  type        = string
}

resource "aws_lambda_function" "my_lambda" {
  filename         = "function.zip"
  function_name    = "my_lambda_function"
  role             = var.lambda_role_arn
  handler          = "index.handler"
  runtime          = "nodejs14.x"
  source_code_hash = filebase64sha256("function.zip") # The function.zip file contains the Node.js application code that will be deployed to AWS Lambda.
  publish          = true
  environment {
    variables = {
      DB_HOST     = var.db_endpoint
      DB_USER     = var.db_username
      DB_PASSWORD = var.db_password
      DB_NAME     = var.db_name
    }
  }
}

resource "aws_lambda_alias" "live" {
  name             = "live"
  description      = "The live alias"
  function_name    = aws_lambda_function.my_lambda.function_name
  function_version = aws_lambda_function.my_lambda.version
}

output "lambda_function_name" {
  value = aws_lambda_function.my_lambda.function_name
}

output "lambda_alias_name" {
  value = aws_lambda_alias.live.name
}






