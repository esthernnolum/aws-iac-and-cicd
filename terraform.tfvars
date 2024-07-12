# terraform.tfvars

# General Settings
region              = "us-east-1"

# VPC Settings
vpc_cidr            = "10.0.0.0/16"
public_subnets      = ["10.0.1.0/24", "10.0.2.0/24"]
private_subnets     = ["10.0.3.0/24", "10.0.4.0/24"]

# RDS Settings
db_username         = "admin"
db_password         = "your_db_password" # Replace with your actual DB password
db_instance_class   = "db.t3.micro"
db_allocated_storage = 20
db_name             = "mydatabase"

# Lambda Settings
lambda_role_arn     = "arn:aws:iam::123456789012:role/lambda-role" # Replace with your actual Lambda role ARN
lambda_function_name = "my_lambda_function"

# RDS Endpoint
db_endpoint         = "your_rds_endpoint" # Replace with your actual RDS endpoint

# CodePipeline and CodeBuild Settings
codepipeline_role_arn = "arn:aws:iam::123456789012:role/codepipeline-role" # Replace with your actual CodePipeline role ARN
codebuild_role_arn  = "arn:aws:iam::123456789012:role/codebuild-role" # Replace with your actual CodeBuild role ARN

# Amplify Settings
amplify_app_id      = "d1m8c0f6e5e8u1" # Replace with your actual Amplify app ID
amplify_branch_name = "main"

# CloudWatch and SNS Settings
db_instance_identifier = "mydbinstance" # Replace with your actual RDS instance identifier
sns_topic_arn       = "arn:aws:sns:us-west-2:123456789012:my-sns-topic" # Replace with your actual SNS topic ARN

# GitHub Token
github_token        = "your_github_token" # Replace with your actual GitHub OAuth token
