# 全体設定
project     = "terraform-aws-sample"
region      = "us-east-1"
environment = "development"

# DNS 関連
domain_name = "shimajiro.tokyo"

# EC2 関連
public_keypair_to_springboard_path = "./keypair/terraform-aws-sample-development-keypair-to-springboard.pub"
public_keypair_to_web_server_path  = "./keypair/terraform-aws-sample-development-keypair-to-web-server.pub"
ami                                = "ami-022e1a32d3f742bd8"
instance_type                      = "t2.micro"