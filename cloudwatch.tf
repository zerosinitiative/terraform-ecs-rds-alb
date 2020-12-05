resource "aws_cloudwatch_log_group" "cluster" {
  name = "/${var.deployment_identifier}/ecs-cluster/${var.cluster_name}"
}