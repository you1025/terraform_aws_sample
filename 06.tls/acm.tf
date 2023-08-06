###################
# Certification
###################

resource "aws_acm_certificate" "this" {
  domain_name       = "*.${var.domain_name}"
  validation_method = "DNS"

  tags = {
    Name        = "${var.project}-${var.environment}-wildcard-ssl-cert"
    Project     = var.project
    Environment = var.environment
  }

  lifecycle {
    create_before_destroy = true
  }
}

resource "aws_acm_certificate_validation" "this" {
  certificate_arn         = aws_acm_certificate.this.arn
  validation_record_fqdns = [for record in aws_route53_record.acm_dns_resolve : record.fqdn]
}