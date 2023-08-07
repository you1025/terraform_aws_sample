###################
# Security Group
###################

# Web Server
resource "aws_security_group" "web" {
  name        = "${var.project}-${var.environment}-web-server-security-group"
  description = "web server security group"
  vpc_id      = aws_vpc.this.id

  tags = {
    Name        = "${var.project}-${var.environment}-web-server-security-group"
    Project     = var.project
    Environment = var.environment
  }
}
resource "aws_security_group_rule" "web_in_http" {
  security_group_id        = aws_security_group.web.id
  type                     = "ingress"
  protocol                 = "tcp"
  from_port                = 80
  to_port                  = 80
  source_security_group_id = aws_security_group.alb.id
  description              = "${var.project}-${var.environment}-web-in-http-rule"
}
resource "aws_security_group_rule" "web_in_ssh" {
  security_group_id = aws_security_group.web.id
  type              = "ingress"
  protocol          = "tcp"
  from_port         = 22
  to_port           = 22
  cidr_blocks       = ["0.0.0.0/0"]
  description       = "${var.project}-${var.environment}-web-in-ssh-rule"
}
resource "aws_security_group_rule" "web_out_http" { # for update
  security_group_id = aws_security_group.web.id
  type              = "egress"
  protocol          = "tcp"
  from_port         = 80
  to_port           = 80
  cidr_blocks       = ["0.0.0.0/0"]
  description       = "${var.project}-${var.environment}-web-out-http-rule"
}
resource "aws_security_group_rule" "web_out_http2" { # for update
  security_group_id = aws_security_group.web.id
  type              = "egress"
  protocol          = "tcp"
  from_port         = 443
  to_port           = 443
  cidr_blocks       = ["0.0.0.0/0"]
  description       = "${var.project}-${var.environment}-web-out-http-rule"
}

# ALB
resource "aws_security_group" "alb" {
  name        = "${var.project}-${var.environment}-alb-security-group"
  description = "alb security group"
  vpc_id      = aws_vpc.this.id

  tags = {
    Name        = "${var.project}-${var.environment}-alb-server-security-group"
    Project     = var.project
    Environment = var.environment
  }
}
resource "aws_security_group_rule" "alb_in_http" {
  security_group_id = aws_security_group.alb.id
  type              = "ingress"
  protocol          = "tcp"
  from_port         = 80
  to_port           = 80
  cidr_blocks       = ["0.0.0.0/0"]
  description       = "${var.project}-${var.environment}-alb-in-http-rule"
}
resource "aws_security_group_rule" "alb_out_http" {
  security_group_id = aws_security_group.alb.id
  type              = "egress"
  protocol          = "tcp"
  from_port         = 80
  to_port           = 80
  cidr_blocks       = ["0.0.0.0/0"]
  description       = "${var.project}-${var.environment}-alb-out-http-rule"
}