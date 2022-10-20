resource "aws_iam_policy" "ec2-s3-readonly" {
  name        = "ec2-s3-readonly"
  description = "ec2-s3-readonly"

  policy = <<EOF
{
  "Version": "2012-10-17",
  "Statement": [
     {
      "Action": [
        "s3:GetObject",
        "s3:ListBucket",
        "s3:ListObjectsV2"
      ],
      "Effect": "Allow",
      "Resource": "*"
    }
  ]
}
EOF
}

resource "aws_iam_policy" "rds-s3-bucket" {
  name        = "rds-s3-bucket"
  description = "rds-s3-bucket"

  policy = <<EOF
{
  "Version": "2012-10-17",
  "Statement": [
     {
      "Action": [
        "s3:*"
      ],
      "Effect": "Allow",
      "Resource": "*"
    }
  ]
}
EOF
}

