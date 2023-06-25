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
  description = "${var.project}-${var.environment}-web-in-http-rule"
}
#resource "aws_security_group_rule" "web_in_https" {
#  security_group_id = aws_security_group.web_sg.id
#  type = "ingress"
#  protocol = "tcp"
#  from_port = 443
#  to_port = 443
#  cidr_blocks = [ "0.0.0.0/0" ]
#}
#resource "aws_security_group_rule" "web_out_tcp3000" {
#  security_group_id = aws_security_group.web_sg.id
#  type = "egress"
#  protocol = "tcp"
#  from_port = 3000
#  to_port = 3000
#  cidr_blocks = [ "0.0.0.0/0" ]
#}
