resource "aws_lb" "ecs_load_balancer" {
  name               = "ecs-load-balancer"
  internal           = false
  load_balancer_type = "application"
  security_groups    = [aws_security_group.main_sg.id]
  subnets = [
    aws_subnet.public_subnets[0].id,
    aws_subnet.public_subnets[1].id,
    aws_subnet.public_subnets[2].id
  ]
}

resource "aws_lb_target_group" "ecs_lb_target_group" {
  name        = "ecs-lb-target-group"
  port        = 80
  protocol    = "HTTP"
  vpc_id      = aws_vpc.main.id
  target_type = "ip"

  health_check {
    interval            = 30
    path                = "/"
    protocol            = "HTTP"
    timeout             = 5
    healthy_threshold   = 2
    unhealthy_threshold = 2
  }
}

resource "aws_lb_listener" "ecs_load_balancer_http" {
  load_balancer_arn = aws_lb.ecs_load_balancer.arn
  port              = 80
  protocol          = "HTTP"

  default_action {
    type             = "forward"
    target_group_arn = aws_lb_target_group.ecs_lb_target_group.arn
  }
}

resource "aws_lb_listener" "ecs_load_balancer_https" {
  load_balancer_arn = aws_lb.ecs_load_balancer.arn
  port              = 443
  protocol          = "HTTPS"
  ssl_policy        = "ELBSecurityPolicy-2016-08"
  certificate_arn   = aws_acm_certificate.kacperwozniak_dev.arn

  default_action {
    type             = "forward"
    target_group_arn = aws_lb_target_group.ecs_lb_target_group.arn
  }
}