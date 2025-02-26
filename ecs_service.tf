# resource "aws_ecs_service" "kacper-wozniak-dev-frontend" {
#   name            = "kacper-wozniak-dev-frontend-prod"
#   cluster         = aws_ecs_cluster.ecs_cluster.id
#   task_definition = aws_ecs_task_definition.kacper_wozniak_dev_frontend.arn
#   desired_count   = 2
#   launch_type     = "FARGATE"
#   task_definition = "kacper-wozniak-dev-frontend-prod:1"

#   network_configuration {
#     subnets          = aws_subnet.public.*.id
#     assign_public_ip = true
#   }


# #   ordered_placement_strategy {
# #     type  = "binpack"
# #     field = "cpu"
# #   }

# #   load_balancer {
# #     target_group_arn = aws_lb_target_group.foo.arn
# #     container_name   = "mongo"
# #     container_port   = 8080
# #   }

# #   placement_constraints {
# #     type       = "memberOf"
# #     expression = "attribute:ecs.availability-zone in [us-west-2a, us-west-2b]"
# #   }
# }