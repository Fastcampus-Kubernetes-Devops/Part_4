resource "aws_s3_bucket" "demo_bucket" {
  bucket_prefix = "demo-bucket"
  force_destroy = true
}
resource "aws_s3_bucket_public_access_block" "block_public_access" {
  bucket = aws_s3_bucket.demo_bucket.id

  block_public_acls       = true
  block_public_policy     = true
  ignore_public_acls      = true
  restrict_public_buckets = true
}
data "aws_iam_policy_document" "demo_policy_document" {
  statement {
    principals {
      type        = "Service"
      identifiers = ["cloudfront.amazonaws.com"]
    }
    actions   = ["s3:GetObject"]
    resources = ["${aws_s3_bucket.demo_bucket.arn}/*"]
    condition {
      test     = "StringEquals"
      variable = "aws:SourceArn"
      values   = [aws_cloudfront_distribution.demo_cf.arn]
    }
  }
}
resource "aws_s3_bucket_policy" "bucket_policy" {
  bucket = aws_s3_bucket.demo_bucket.id
  policy = data.aws_iam_policy_document.demo_policy_document.json
}
resource "aws_s3_object" "demo_object" {
  bucket = aws_s3_bucket.demo_bucket.id

  key          = "index.html"
  content      = "Hello World!"
  content_type = "text/html"
}
