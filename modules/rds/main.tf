variable "vpc_id" {
  description = "The ID of the VPC"
  type        = string
}

variable "private_subnet_ids" {
  description = "The IDs of the private subnets"
  type        = list(string)
}

variable "security_group_id" {
  description = "The ID of the security group"
  type        = string
}

module "db" {
  source  = "terraform-aws-modules/rds/aws"
  version = "3.2.0"
  identifier = "mydb"
  engine = "mysql"
  instance_class = "db.t2.micro"
  allocated_storage = 20
  name     = "mydatabase"
  username = "admin"
  password = "mypassword"
  port     = 3306
  vpc_security_group_ids = [var.security_group_id]
  subnet_ids = var.private_subnet_ids

  parameter_group_name = "default.mysql5.7"

  tags = {
    Terraform = "true"
    Environment = "dev"
  }
}

output "db_endpoint" {
  value = module.db.this_rds_instance_endpoint
}

output "db_username" {
  value = "admin"
}

output "db_password" {
  value = "mypassword"
}

output "db_name" {
  value = "mydatabase"
}

output "db_instance_identifier" {
  value = module.db.this_db_instance_identifier
}
