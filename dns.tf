resource "aws_route53_zone" "kacperwozniak_dev" {
  name = "kacperwozniak.dev"  
}

resource "aws_acm_certificate" "kacperwozniak_dev" {
  domain_name       = "kacperwozniak.dev"
  validation_method = "DNS"

  tags = {
    Name = "kacperwozniak.dev"
  }
}

resource "aws_route53_record" "kacperwozniak_dev" {
  zone_id = aws_route53_zone.kacperwozniak_dev.zone_id
  name    = "_de771045b9ef221a8899774096d0cb81"
  type    = "CNAME"
  ttl    = "300"
  records        = ["_39a0fb5c9b7d2761e5cffd38e4fbba37.zfyfvmchrl.acm-validations.aws."]
}

resource "aws_route53_record" "kacperwozniak_dev_www_a" {
  zone_id = aws_route53_zone.kacperwozniak_dev.id

  name    = "www.kacperwozniak.dev"  
  type    = "A"
  alias {
    name                   = aws_lb.ecs_load_balancer.dns_name
    zone_id                = aws_lb.ecs_load_balancer.zone_id
    evaluate_target_health = true
  }
}

resource "aws_route53_record" "kacperwozniak_dev_a" {
  zone_id = aws_route53_zone.kacperwozniak_dev.id

  name    = "kacperwozniak.dev"  
  type    = "A"
  alias {
    name                   = aws_lb.ecs_load_balancer.dns_name
    zone_id                = aws_lb.ecs_load_balancer.zone_id
    evaluate_target_health = true
  }
}
