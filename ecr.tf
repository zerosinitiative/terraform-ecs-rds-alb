resource "aws_ecr_repository" "test" {
  name = "${var.deployment_identifier}-${var.cluster_name}-app"

  image_scanning_configuration {
    scan_on_push = true
  }
}