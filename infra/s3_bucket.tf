resource "aws_s3_bucket" "frontend_bucket" {
  bucket        = "tuannamnguyen-resume-frontend-bucket"
  force_destroy = true
}

resource "aws_s3_bucket_public_access_block" "fe_bucket_access_block" {
  bucket = aws_s3_bucket.frontend_bucket.id

  block_public_acls       = false
  ignore_public_acls      = false
  block_public_policy     = false
  restrict_public_buckets = false
}

resource "aws_s3_bucket_website_configuration" "fe_static_site_config" {
  bucket = aws_s3_bucket.frontend_bucket.id

  index_document {
    suffix = "index.html"
  }
}


resource "aws_s3_bucket_policy" "fe_bucket_policy" {
  bucket = aws_s3_bucket.frontend_bucket.id
  policy = jsonencode({
    "Version" : "2012-10-17",
    "Statement" : [
      {
        "Sid" : "PublicReadGetObject",
        "Effect" : "Allow",
        "Principal" : "*",
        "Action" : [
          "s3:GetObject"
        ],
        "Resource" : [
          "arn:aws:s3:::${aws_s3_bucket.frontend_bucket.bucket}/*"
        ]
      }
    ]
  })
}


resource "aws_s3_object" "index_file" {
  bucket = aws_s3_bucket.frontend_bucket.id
  key = "index.html"
  source = "../index.html"
}