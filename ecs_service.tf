resource "aws_ecs_service" "kacper-wozniak-dev-frontend" {
  name            = "kacper-wozniak-dev-frontend-prod"
  cluster         = aws_ecs_cluster.ecs_cluster.id
  task_definition = aws_ecs_task_definition.kacper_wozniak_dev_frontend.arn
  desired_count   = 1
  launch_type     = "FARGATE"
  network_configuration {
    subnets = [
      aws_subnet.public_subnets[0].id,
      aws_subnet.public_subnets[1].id,
      aws_subnet.public_subnets[2].id
    ]
    assign_public_ip = true
    security_groups  = [aws_security_group.main_sg.id]
  }

  load_balancer {
    target_group_arn = aws_lb_target_group.ecs_lb_target_group.arn
    container_name   = "kacper-wozniak-frontend"
    container_port   = 3000
  }

}