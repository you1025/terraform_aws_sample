###################
# Route53
###################

resource "aws_route53_record" "A" {
  zone_id = var.host_zone_id
  name    = "alb.${var.domain_name}"
  type    = "A"

  alias {
    name                   = aws_lb.alb.dns_name
    zone_id                = aws_lb.alb.zone_id
    evaluate_target_health = true
  }
}