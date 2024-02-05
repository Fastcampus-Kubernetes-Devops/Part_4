resource "aws_cloudfront_origin_access_control" "demo_oac" {
  name                              = "demo-oac"
  origin_access_control_origin_type = "s3"
  signing_behavior                  = "always"
  signing_protocol                  = "sigv4"
}

resource "aws_cloudfront_distribution" "demo_cf" {
  enabled             = true
  default_root_object = "index.html"

  origin {
    origin_id                = aws_s3_bucket.demo_bucket.id
    domain_name              = aws_s3_bucket.demo_bucket.bucket_regional_domain_name
    origin_access_control_id = aws_cloudfront_origin_access_control.demo_oac.id
  }

  default_cache_behavior {
    allowed_methods = ["GET", "HEAD"]
    cached_methods  = ["GET", "HEAD"]

    cache_policy_id  = data.aws_cloudfront_cache_policy.demo_cache_policy.id
    target_origin_id = aws_s3_bucket.demo_bucket.id

    viewer_protocol_policy = "redirect-to-https"
  }

  restrictions {
    geo_restriction {
      restriction_type = "none"
    }
  }

  viewer_certificate {
    cloudfront_default_certificate = true
  }
}
data "aws_cloudfront_cache_policy" "demo_cache_policy" {
  name = "Managed-CachingOptimized"
}
