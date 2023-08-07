###################
# Key Pair
###################

resource "aws_key_pair" "web_server" {
  key_name   = "${var.project}-${var.environment}-internal"
  public_key = file("../keypair/shimatest-internal.pub")

  tags = {
    Name        = "${var.project}-${var.environment}-keypair-to-internal"
    Project     = var.project
    Environment = var.environment
  }
}


###################
# Launch Template
###################

resource "aws_launch_template" "web" {
  update_default_version = true

  name     = "${var.project}-${var.environment}-web-launch-template"
  image_id = var.template_image_id
  key_name = aws_key_pair.web_server.key_name

  tag_specifications {
    resource_type = "instance"
    tags = {
      Name        = "${var.project}-${var.environment}-web-server"
      Project     = var.project
      Environment = var.environment
      Type        = "web server"
    }
  }

  network_interfaces {
    associate_public_ip_address = true
    security_groups = [
      aws_security_group.web.id
    ]
    delete_on_termination = true
  }

  # 初期設定
  user_data = filebase64("../user_data/web_server.sh")
}


#####################
# Auto Scaling Group
#####################

resource "aws_autoscaling_group" "web" {
  name = "${var.project}-${var.environment}-web-auto-scaling-group"

  min_size         = 1
  max_size         = 1
  desired_capacity = 1

  health_check_grace_period = 300
  health_check_type         = "ELB"

  vpc_zone_identifier = [
    aws_subnet.public_1a.id,
    aws_subnet.public_2c.id
  ]

  target_group_arns = [aws_lb_target_group.this.arn]

  mixed_instances_policy {
    launch_template {
      launch_template_specification {
        launch_template_id = aws_launch_template.web.id
        version            = "$Latest"
      }
      override {
        instance_type = var.instance_type
      }
    }
  }
}