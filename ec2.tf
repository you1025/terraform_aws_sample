###################
# Key Pair
###################

variable "public_keypair_path" {
  type = string
}

resource "aws_key_pair" "keypair" {
  key_name   = "${var.project}-${var.environment}-keypair"
  public_key = file(var.public_keypair_path)

  tags = {
    Name        = "${var.project}-${var.environment}-keypair"
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
  key_name = aws_key_pair.keypair.key_name

  # 初期設定
  user_data = file("./user_data/web_server.sh")

  tags = {
    Name        = "${var.project}-${var.environment}-igw"
    Project     = var.project
    Environment = var.environment
    Type        = "web server"
  }
}
