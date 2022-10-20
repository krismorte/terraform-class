resource "aws_s3_bucket" "bucket" {
  bucket = "bucket.test.com.br"

  force_destroy = true

}