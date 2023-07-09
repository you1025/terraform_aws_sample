###################
# Key Pair
###################

resource "aws_key_pair" "springboard" {
  key_name   = "${var.project}-springboard"
  public_key = file("../keypair/shimatest-springboard.pub")

  tags = {
    Name        = "${var.project}-${var.environment}-keypair-to-springboard"
    Project     = var.project
    Environment = var.environment
  }
}


###################
# EC2 Instance
###################

resource "aws_instance" "springboard" {
  ami                         = var.ami
  instance_type               = var.instance_type
  subnet_id                   = aws_subnet.public_1a.id
  associate_public_ip_address = true
  vpc_security_group_ids = [
    aws_security_group.springboard.id
  ]
  key_name = aws_key_pair.springboard.key_name

  user_data = file("../user_data/springboard_server.sh")

  tags = {
    Name        = "${var.project}-${var.environment}-springboard-server"
    Project     = var.project
    Environment = var.environment
    Type        = "springboard server"
  }
}


###################
# Elastic IP
###################

resource "aws_eip" "springboard" {
  instance = aws_instance.springboard.id
}