###################
# Key Pair
###################

variable "public_keypair_to_springboard_path" {
  type = string
}
variable "public_keypair_to_web_server_path" {
  type = string
}

resource "aws_key_pair" "keypair_to_springboard" {
  key_name   = "${var.project}-${var.environment}-keypair-to-springboard"
  public_key = file(var.public_keypair_to_springboard_path)

  tags = {
    Name        = "${var.project}-${var.environment}-keypair-to-springboard"
    Project     = var.project
    Environment = var.environment
  }
}
resource "aws_key_pair" "keypair_to_web_server" {
  key_name   = "${var.project}-${var.environment}-to-web-server"
  public_key = file(var.public_keypair_to_web_server_path)

  tags = {
    Name        = "${var.project}-${var.environment}-keypair-to-web-server"
    Project     = var.project
    Environment = var.environment
  }
}


###################
# EC2 Instance
###################

variable "ami" {
  type = string
}
variable "instance_type" {
  type = string
}

resource "aws_instance" "web_server" {
  ami                         = var.ami
  instance_type               = var.instance_type
  subnet_id                   = aws_subnet.public_subnet_1a.id
  associate_public_ip_address = true
  vpc_security_group_ids = [
    aws_security_group.web_sg.id
  ]
  key_name = aws_key_pair.keypair_to_web_server.key_name

  # 初期設定
  user_data = file("./user_data/web_server.sh")

  tags = {
    Name        = "${var.project}-${var.environment}-web-server"
    Project     = var.project
    Environment = var.environment
    Type        = "web server"
  }
}

resource "aws_instance" "springboard_server" {
  ami                         = var.ami
  instance_type               = var.instance_type
  subnet_id                   = aws_subnet.public_subnet_2a.id
  associate_public_ip_address = true
  vpc_security_group_ids = [
    aws_security_group.springboard_sg.id
  ]
  key_name = aws_key_pair.keypair_to_springboard.key_name

  user_data = file("./user_data/springboard_server.sh")

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

resource "aws_eip" "springboard-public-ip" {
  instance = aws_instance.springboard_server.id
}
resource "aws_eip" "web-public-ip" {
  instance = aws_instance.web_server.id
}