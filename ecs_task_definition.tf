resource "aws_ecs_task_definition" "kacper_wozniak_dev_frontend" {
  family = "kacper-wozniak-dev-frontend-prod"
  requires_compatibilities = ["FARGATE"]
  network_mode             = "awsvpc"
  execution_role_arn       = aws_iam_role.ecs_execution_role.arn
  cpu                      = 1024
  memory                   = 2048
  container_definitions = jsonencode([
    {
      name      = "kacper-wozniak-frontend"
      image     = "586794448788.dkr.ecr.eu-west-3.amazonaws.com/kacper-wozniak-frontend:v1.0.0"
      essential = true
      portMappings = [
        {
          containerPort = 3000
          hostPort      = 3000
        }
      ]
    }
  ])
}