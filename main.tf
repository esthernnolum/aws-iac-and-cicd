provider "aws" {
  region = "us-west-2"
}

module "vpc" {
  source = "./modules/vpc"
}

module "security_group" {
  source  = "./modules/security_group"
  vpc_id  = module.vpc.vpc_id
  cidr_blocks = [module.vpc.vpc_cidr_block]
}

module "rds" {
  source                = "./modules/rds"
  vpc_id                = module.vpc.vpc_id
  private_subnet_ids    = module.vpc.private_subnets
  security_group_id     = module.security_group.rds_sg_id
}

module "iam" {
  source = "./modules/iam"
}

module "lambda" {
  source                  = "./modules/lambda"
  lambda_role_arn         = module.iam.lambda_role_arn
  db_endpoint             = module.rds.db_endpoint
  db_username             = module.rds.db_username
  db_password             = module.rds.db_password
  db_name                 = module.rds.db_name
}

module "amplify" {
  source = "./modules/amplify"
}

module "codepipeline" {
  source                  = "./modules/codepipeline"
  codepipeline_role_arn   = module.iam.codepipeline_role_arn
  codebuild_role_arn      = module.iam.codebuild_role_arn
  amplify_app_id          = module.amplify.app_id
  amplify_branch_name     = module.amplify.branch_name
  lambda_function_name    = module.lambda.lambda_function_name
}

module "cloudwatch" {
  source                  = "./modules/cloudwatch"
  lambda_function_name    = module.lambda.lambda_function_name
  db_instance_identifier  = module.rds.db_instance_identifier
  sns_topic_arn           = module.iam.sns_topic_arn
}
