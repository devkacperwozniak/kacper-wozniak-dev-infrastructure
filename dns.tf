resource "aws_route53_zone" "kacperwozniak_dev" {
  name = "kacperwozniak.dev"  
}

# output "name_servers" {
#   value = aws_route53_zone.kacperwozniak_dev.name_servers
# }

resource "aws_acm_certificate" "kacperwozniak_dev" {
  domain_name       = "www.kacperwozniak.dev"
  validation_method = "DNS"

  tags = {
    Name = "kacperwozniak.dev"
  }
}

resource "aws_route53_record" "kacperwozniak_dev" {
  zone_id = aws_route53_zone.kacperwozniak_dev.id

  name    = "www.kacperwozniak.dev"  
  type    = "A"
  alias {
    name                   = aws_lb.ecs_load_balancer.dns_name
    zone_id                = aws_lb.ecs_load_balancer.zone_id
    evaluate_target_health = true
  }
}

# resource "aws_lb_listener_certificate" "kacperwozniak_dev" {
#   listener_arn     = aws_lb_listener.ecs_load_balancer_http.arn
#   certificate_arn  = aws_acm_certificate.kacperwozniak_dev.arn
# }
