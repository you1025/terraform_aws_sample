######
# S3
######

resource "random_string" "s3_unique_key" {
  length  = 6
  upper   = false
  lower   = true
  numeric = true
  special = false
}

resource "aws_s3_bucket" "test" {
  bucket        = "${var.project}-${var.environment}-${random_string.s3_unique_key.result}"
  force_destroy = true
}