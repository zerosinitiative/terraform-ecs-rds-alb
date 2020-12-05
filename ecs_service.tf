resource "aws_ecs_service" "test" {
  name            = "${var.deployment_identifier}-${var.cluster_name}-service"
  cluster         = aws_ecs_cluster.cluster.id
  task_definition = aws_ecs_task_definition.app.arn
  desired_count   = 0
  iam_role        = aws_iam_role.cluster_service_role.arn
  depends_on      = [aws_iam_role.cluster_service_role, aws_lb.test]

  load_balancer {
    target_group_arn = aws_lb_target_group.test.arn
    container_name   = "nginx"
    container_port   = 9000
  }
}