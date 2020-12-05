provider "aws" {
  version = "= 2.65"
  region  = "ap-south-1"
}

terraform {
  backend "s3" {
    bucket = "terraform-backend-app"
    key    = "tfstate/dev/terraform.tfstate"
    region = "ap-south-1"
    profile = "aws-akshay"
  }
}

module "ecs_cluster" {
  source = "../../../"
  providers = {
    aws      = aws
  }

  region     = "ap-south-1"
  vpc_id     = "vpc-884c43e0"
  subnet_ids = ["subnet-2ca70b57","subnet-1da39675","subnet-8947ddc5"]

  deployment_identifier = "dev"

  cluster_name                         = "app"
  cluster_instance_ssh_public_key_path = "/Users/akshaypk/.ssh/id_rsa.pub"
  cluster_instance_type                = "t3.small"

  cluster_minimum_size     = 0
  cluster_maximum_size     = 0
  cluster_desired_capacity = 0

  password = "password123"
  db_name  = "student"
}

output "alb_arn" {
  description = "Output ARN of the Load Balancer"
  value = module.ecs_cluster.alb_arn
}

output "log_group" {
  description = "The name of the default log group for the cluster."
  value       = module.ecs_cluster.log_group
}