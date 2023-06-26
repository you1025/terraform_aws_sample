###################
# Route53
###################

variable "domain_name" {
  type = string
}

resource "aws_route53_zone" "route53_zone" {
  name          = var.domain_name
  force_destroy = false

  tags = {
    Name        = "${var.project}-${var.environment}-route53-zone"
    Project     = var.project
    Environment = var.environment
  }

  lifecycle {
    prevent_destroy = true
  }
}

resource "aws_route53_record" "route53_record" {
  zone_id = aws_route53_zone.route53_zone.id
  name    = var.domain_name
  type    = "A"
  ttl     = 300
  records = [aws_eip.web-public-ip.public_ip]

  lifecycle {
    prevent_destroy = true
  }
}