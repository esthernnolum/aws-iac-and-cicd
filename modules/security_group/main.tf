variable "vpc_id" {
  description = "The ID of the VPC"
  type        = string
}

variable "cidr_blocks" {
  description = "The list of CIDR blocks"
  type        = list(string)
}

resource "aws_security_group" "rds_sg" {
  name        = "rds_sg"
  description = "Allow MySQL traffic"
  vpc_id      = var.vpc_id

  ingress {
    from_port   = 3306
    to_port     = 3306
    protocol    = "tcp"
    cidr_blocks = var.cidr_blocks
  }

  egress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }
}

output "rds_sg_id" {
  value = aws_security_group.rds_sg.id
}
