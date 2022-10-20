resource "aws_iam_role_policy_attachment" "role-ec2-s3-readonly" {
  role       = aws_iam_role.ec2-role.name
  policy_arn = aws_iam_policy.ec2-s3-readonly.arn
}

resource "aws_iam_role_policy_attachment" "role-rds-s3-bucket" {
  role       = aws_iam_role.rds-role.name
  policy_arn = aws_iam_policy.rds-s3-bucket.arn
}