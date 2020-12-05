resource "aws_ecs_task_definition" "app" {
  family = "${var.deployment_identifier}-${var.cluster_name}-taskdfn"

  container_definitions = <<EOF
[
  {
    "name": "nginx",
    "image": "nginx:1.13-alpine",
    "essential": true,
    "portMappings": [
      {
        "containerPort": 9000,
        "hostPort": 0
      }
    ],
    "logConfiguration": {
      "logDriver": "awslogs",
      "options": {
        "awslogs-group": "/${var.deployment_identifier}/ecs-cluster/${var.cluster_name}",
        "awslogs-region": "ap-south-1"
      }
    },
    "memory": 1024,
    "cpu": 2
  }
]
EOF
}