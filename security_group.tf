###################
# Security Group
###################

# Web Server
resource "aws_security_group" "web_sg" {
  name        = "${var.project}-${var.environment}-web-sg"
  description = "web front role security group"
  vpc_id      = aws_vpc.vpc.id

  tags = {
    Name        = "${var.project}-${var.environment}-web-sg"
    Project     = var.project
    Environment = var.environment
  }
}
resource "aws_security_group_rule" "web_in_http" {
  security_group_id = aws_security_group.web_sg.id
  type              = "ingress"
  protocol          = "tcp"
  from_port         = 80
  to_port           = 80
  cidr_blocks       = ["0.0.0.0/0"]
  description       = "${var.project}-${var.environment}-web-in-http-rule"
}
resource "aws_security_group_rule" "web_in_ssh" {
  security_group_id = aws_security_group.web_sg.id
  type              = "ingress"
  protocol          = "tcp"
  from_port         = 22
  to_port           = 22
  cidr_blocks       = ["0.0.0.0/0"]
  description       = "${var.project}-${var.environment}-web-in-ssh-rule"
}
resource "aws_security_group_rule" "web_out_http" {
  security_group_id = aws_security_group.web_sg.id
  type              = "egress"
  protocol          = "tcp"
  from_port         = 80
  to_port           = 80
  cidr_blocks       = ["0.0.0.0/0"]
  description       = "${var.project}-${var.environment}-web-out-http-rule"
}
resource "aws_security_group_rule" "web_out_https" {
  security_group_id = aws_security_group.web_sg.id
  type              = "egress"
  protocol          = "tcp"
  from_port         = 443
  to_port           = 443
  cidr_blocks       = ["0.0.0.0/0"]
  description       = "${var.project}-${var.environment}-web-out-https-rule"
}
resource "aws_security_group_rule" "web_out_tcp3306" {
  security_group_id        = aws_security_group.web_sg.id
  type                     = "egress"
  protocol                 = "tcp"
  from_port                = 3306
  to_port                  = 3306
  source_security_group_id = aws_security_group.db_sg.id
  description              = "${var.project}-${var.environment}-web-out-tcp3306-rule"
}

# DB
resource "aws_security_group" "db_sg" {
  name        = "${var.project}-${var.environment}-db-sg"
  description = "database role security group"
  vpc_id      = aws_vpc.vpc.id

  tags = {
    Name        = "${var.project}-${var.environment}-db-sg"
    Project     = var.project
    Environment = var.environment
  }
}
resource "aws_security_group_rule" "db_in_tcp3306" {
  security_group_id        = aws_security_group.db_sg.id
  type                     = "ingress"
  protocol                 = "tcp"
  from_port                = 3306
  to_port                  = 3306
  source_security_group_id = aws_security_group.web_sg.id
  description              = "${var.project}-${var.environment}-db-in-tcp3306-rule"
}