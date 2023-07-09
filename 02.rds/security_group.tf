###################
# Security Group
###################

# springboard
resource "aws_security_group" "springboard" {
  name        = "${var.project}-${var.environment}-springboard-security-group"
  vpc_id      = aws_vpc.this.id
  description = "springboard security group"

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
resource "aws_security_group_rule" "springboard_out_tcp3306" {
  security_group_id        = aws_security_group.springboard.id
  type                     = "egress"
  protocol                 = "tcp"
  from_port                = 3306
  to_port                  = 3306
  source_security_group_id = aws_security_group.db.id
  description              = "${var.project}-${var.environment}-springboard-out-tcp3306-rule"
}
resource "aws_security_group_rule" "springboard_out_http" {
  security_group_id = aws_security_group.springboard.id
  type              = "egress"
  protocol          = "tcp"
  from_port         = 80
  to_port           = 80
  cidr_blocks       = ["0.0.0.0/0"]
  description       = "${var.project}-${var.environment}-springboard-out-http-rule"
}
resource "aws_security_group_rule" "springboard_out_https" {
  security_group_id = aws_security_group.springboard.id
  type              = "egress"
  protocol          = "tcp"
  from_port         = 443
  to_port           = 443
  cidr_blocks       = ["0.0.0.0/0"]
  description       = "${var.project}-${var.environment}-springboard-out-https-rule"
}

# RDS
resource "aws_security_group" "db" {
  name        = "${var.project}-${var.environment}-db-security-group"
  vpc_id      = aws_vpc.this.id
  description = "rds security group"

  tags = {
    Name        = "${var.project}-${var.environment}-db-security-group"
    Project     = var.project
    Environment = var.environment
  }
}
resource "aws_security_group_rule" "db_in_tcp3306" {
  security_group_id        = aws_security_group.db.id
  type                     = "ingress"
  protocol                 = "tcp"
  from_port                = 3306
  to_port                  = 3306
  source_security_group_id = aws_security_group.springboard.id
  description              = "${var.project}-${var.environment}-db-in-tcp3306-rule"
}