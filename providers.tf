terraform {
  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = "~> 5.0"
    }
  }
}

# Configure the AWS Provider
provider "aws" {
  region = "us-east-1"
}

terraform {
  backend "s3" {
    bucket = "aws-iac-and-cicd-bucket"
    key    = "terraform.tfstate"
    region = "us-east-1"
    encrypt = true
#    dynamodb_table = "terraform-state-lock"
  }
}