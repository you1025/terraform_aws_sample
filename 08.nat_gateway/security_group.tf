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
resource "aws_security_group_rule" "web_in_ssh" {
  security_group_id        = aws_security_group.web.id
  type                     = "ingress"
  protocol                 = "tcp"
  from_port                = 22
  to_port                  = 22
  source_security_group_id = aws_security_group.springboard.id
  description              = "${var.project}-${var.environment}-web-in-ssh-rule"
}
resource "aws_security_group_rule" "web_out_http" {
  security_group_id = aws_security_group.web.id
  type              = "egress"
  protocol          = "tcp"
  from_port         = 80
  to_port           = 80
  cidr_blocks       = ["0.0.0.0/0"]
  description       = "${var.project}-${var.environment}-web-out-ssh-rule"
}

# springboard
resource "aws_security_group" "springboard" {
  name        = "${var.project}-${var.environment}-springboard-security-group"
  description = "springboard security group"
  vpc_id      = aws_vpc.this.id

  tags = {
    Name        = "${var.project}-${var.environment}-springboard-security-group"
    Project     = var.project
    Environment = var.environment
  }
}
resource "aws_security_group_rule" "springboard_in_ssh" {
  security_group_id = aws_security_group.springboard.id
  type              = "ingress"
  protocol          = "tcp"
  from_port         = 22
  to_port           = 22
  cidr_blocks       = ["0.0.0.0/0"]
  description       = "${var.project}-${var.environment}-springboard-in-ssh-rule"
}
resource "aws_security_group_rule" "springboard_out_ssh" {
  security_group_id        = aws_security_group.springboard.id
  type                     = "egress"
  protocol                 = "tcp"
  from_port                = 22
  to_port                  = 22
  source_security_group_id = aws_security_group.web.id
  description              = "${var.project}-${var.environment}-springboard-out-ssh-rule"
}