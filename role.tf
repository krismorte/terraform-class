resource "aws_iam_role" "ec2-role" {
  name = "ec2-role"

  assume_role_policy = file("${path.module}/ec2.json")
}

resource "aws_iam_role" "rds-role" {
  name = "rds-role"

  assume_role_policy = file("${path.module}/rds.json")
}