###################
# ALB
###################

resource "aws_lb" "alb" {
  name               = "${var.project}-${var.environment}-alb"
  internal           = false
  load_balancer_type = "application"
  security_groups = [
    aws_security_group.alb.id
  ]
  subnets = [
    aws_subnet.public_1a.id,
    aws_subnet.public_2c.id
  ]

  tags = {
    Name        = "${var.project}-${var.environment}-alb"
    Project     = var.project
    Environment = var.environment
  }
}

resource "aws_lb_listener" "http" {
  load_balancer_arn = aws_lb.alb.arn
  port              = 80
  protocol          = "HTTP"

  default_action {
    type             = "forward"
    target_group_arn = aws_lb_target_group.this.arn
  }
}

###################
# Target Group
###################

resource "aws_lb_target_group" "this" {
  name     = "${var.project}-${var.environment}-alb-tg"
  port     = 80
  protocol = "HTTP"
  vpc_id   = aws_vpc.this.id

  tags = {
    Name        = "${var.project}-${var.environment}-alb-tg"
    Project     = var.project
    Environment = var.environment
  }
}
resource "aws_lb_target_group_attachment" "instance1" {
  target_group_arn = aws_lb_target_group.this.arn
  target_id        = aws_instance.web_server1.id
}
resource "aws_lb_target_group_attachment" "instance2" {
  target_group_arn = aws_lb_target_group.this.arn
  target_id        = aws_instance.web_server2.id
}