resource "aws_lb_target_group" "test" {
  name     = "${var.deployment_identifier}-${var.cluster_name}-tg"
  port     = 80
  protocol = "HTTP"
  vpc_id   = var.vpc_id
}