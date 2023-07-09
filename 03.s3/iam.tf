######
# IAM
######

resource "aws_iam_instance_profile" "this" {
  name = "${var.project}-${var.environment}-instance-profile"
  role = aws_iam_role.this.name
}

resource "aws_iam_role" "this" {
  name               = "shimatest-role"
  assume_role_policy = data.aws_iam_policy_document.ec2_assume_role.json
}
data "aws_iam_policy_document" "ec2_assume_role" {
  statement {
    actions = ["sts:AssumeRole"]
    principals {
      type        = "Service"
      identifiers = ["ec2.amazonaws.com"]
    }
  }
}

resource "aws_iam_role_policy_attachment" "s3" {
  role       = aws_iam_role.this.name
  policy_arn = aws_iam_policy.s3.arn
}
resource "aws_iam_policy" "s3" {
  name   = "${var.project}-${var.environment}-s3-policy"
  policy = data.aws_iam_policy_document.s3.json
}
data "aws_iam_policy_document" "s3" {
  statement {
    actions = ["s3:*"]
    effect  = "Allow"
    resources = [
      "${aws_s3_bucket.test.arn}",
      "${aws_s3_bucket.test.arn}/*"
    ]
  }
}

