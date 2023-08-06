###################
# Route53
###################

resource "aws_route53_zone" "this" {
  name          = var.domain_name
  force_destroy = false

  tags = {
    Name        = "${var.project}-${var.environment}-route53-zone"
    Project     = var.project
    Environment = var.environment
  }
}

resource "aws_route53_record" "A" {
  zone_id = aws_route53_zone.this.id
  name    = var.domain_name
  type    = "A"
  ttl     = 300
  records = [
    #aws_eip.hoge.public_ip
    "xxx.xxx.xxx.xxx"
  ]
}