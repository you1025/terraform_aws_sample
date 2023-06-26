# 全体設定
project     = "terraform-aws-sample"
region      = "us-east-1"
environment = "development"

# DNS 関連
domain_name = "shimajiro.tokyo"

# EC2 関連
public_keypair_path = "./keypair/terraform-aws-sample-development-keypair.pub"
ami                 = "ami-022e1a32d3f742bd8"
instance_type       = "t2.micro"