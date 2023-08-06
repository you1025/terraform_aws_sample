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

resource "aws_route53_record" "acm_dns_resolve" {
  for_each = {
    for dvo in aws_acm_certificate.this.domain_validation_options : dvo.domain_name => {
      name   = dvo.resource_record_name
      type   = dvo.resource_record_type
      record = dvo.resource_record_value
    }
  }

  allow_overwrite = true
  zone_id         = var.host_zone_id
  name            = each.value.name
  type            = each.value.type
  ttl             = 600
  records         = [each.value.record]
}