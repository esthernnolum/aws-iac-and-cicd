terraform {
  backend "s3" {
    bucket = "aws-iac-and-cicd-bucket"
    key    = "terraform.tfstate"
    region = "us-east-1"
  }
}