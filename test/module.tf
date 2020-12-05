module "ecs_cluster" {
  source = "../"

  region     = "ap-south-1"
  vpc_id     = ""
  subnet_ids = []

  deployment_identifier = "dev"

  cluster_name                         = "app"
  cluster_instance_ssh_public_key_path = ""
  cluster_instance_type                = "t3.small"

  cluster_minimum_size     = 0
  cluster_maximum_size     = 0
  cluster_desired_capacity = 0

  password = ""
  db_name  = "student"
}