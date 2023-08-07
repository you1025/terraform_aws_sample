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
# EC2 Instance
###################

resource "aws_instance" "web_server" {
  ami           = var.ami
  instance_type = var.instance_type
  subnet_id     = aws_subnet.private_2a.id
  vpc_security_group_ids = [
    aws_security_group.web.id
  ]
  key_name = aws_key_pair.web_server.key_name

  tags = {
    Name        = "${var.project}-${var.environment}-web-server"
    Project     = var.project
    Environment = var.environment
    Type        = "web server"
  }
}

resource "aws_instance" "springboard" {
  ami                         = var.ami
  instance_type               = var.instance_type
  subnet_id                   = aws_subnet.public_1a.id
  associate_public_ip_address = true
  vpc_security_group_ids = [
    aws_security_group.springboard.id
  ]
  key_name = aws_key_pair.springboard.key_name

  tags = {
    Name        = "${var.project}-${var.environment}-springboard-server"
    Project     = var.project
    Environment = var.environment
    Type        = "springboard server"
  }
}
