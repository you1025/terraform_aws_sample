###################
# S3 static bucket
###################

resource "random_string" "s3_unique_key" {
  length  = 6
  upper   = false
  lower   = true
  numeric = true
  special = false
}

resource "aws_s3_bucket" "s3_static_bucket" {
  bucket = "${var.project}-${var.environment}-statuc-bucket-${random_string.s3_unique_key.result}"

}

resource "aws_s3_bucket_versioning" "name" {
  bucket = aws_s3_bucket.s3_static_bucket.id
  versioning_configuration {
    status = "Disabled"
  }
}

resource "aws_s3_bucket_public_access_block" "s3_static_bucket" {
  bucket                  = aws_s3_bucket.s3_static_bucket.id
  block_public_acls       = true
  block_public_policy     = true
  ignore_public_acls      = true
  restrict_public_buckets = false
}

resource "aws_s3_bucket_policy" "s3_static_bucket" {
  bucket = aws_s3_bucket.s3_static_bucket.id
  policy = data.aws_iam_policy_document.s3_static_bucket.json

  depends_on = [
    aws_s3_bucket_public_access_block.s3_static_bucket
  ]
}

data "aws_iam_policy_document" "s3_static_bucket" {
  statement {
    effect    = "Allow"
    actions   = ["s3:GetObject"]
    resources = [
      aws_s3_bucket.s3_static_bucket.arn,
      "${aws_s3_bucket.s3_static_bucket.arn}/*"
    ]
    principals {
      type        = "*"
      identifiers = ["*"]
    }
  }
}