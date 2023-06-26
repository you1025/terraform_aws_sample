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