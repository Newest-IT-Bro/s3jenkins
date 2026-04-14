resource "aws_s3_bucket" "public_jenkins_bucket" {
  bucket = "s3jenkins-bucket-public"
  force_destroy = false
}

resource "aws_s3_bucket_versioning" "public_jenkins_versioning" {
  bucket = aws_s3_bucket.public_jenkins_bucket.id
  versioning_configuration {
    status = "Enabled"
  }
}

resource "aws_s3_bucket_public_access_block" "public_access" {
  bucket = aws_s3_bucket.public_jenkins_bucket.id

  block_public_acls       = false
  block_public_policy     = false
  ignore_public_acls      = false
  restrict_public_buckets = false
}

resource "aws_s3_bucket_policy" "public_policy" {
  bucket = aws_s3_bucket.public_jenkins_bucket.id

  depends_on = [
    aws_s3_bucket_public_access_block.public_access
  ]

  policy = jsonencode({
    Version = "2012-10-17"
    Statement = [
      {
        Sid       = "PublicReadGetObject"
        Effect    = "Allow"
        Principal = "*"
        Action    = "s3:GetObject"
        Resource  = "${aws_s3_bucket.public_jenkins_bucket.arn}/*"
      }
    ]
  })
}
resource "aws_s3_object" "Armageddon" {
  bucket = aws_s3_bucket.public_jenkins_bucket.id
  key    = "Armageddon.md"
  source = "${path.module}/Armageddon.md"
  content_type = "text/markdown"

  etag   = filemd5("${path.module}/Armageddon.md")
}

resource "aws_s3_object" "extension" {
  bucket = aws_s3_bucket.public_jenkins_bucket.id
  key    = "extension.jpg"
  source = "${path.module}/screenshots/extension.jpg"
  content_type = "image/jpg"

  etag   = filemd5("${path.module}/screenshots/extension.jpg")
}

resource "aws_s3_object" "Jenkins-Webhook" {
  bucket = aws_s3_bucket.public_jenkins_bucket.id
  key    = "Jenkins-Webhook.jpg"
  source = "${path.module}/screenshots/Jenkins-Webhook.jpg"
  content_type = "image/jpg"

  etag   = filemd5("${path.module}/screenshots/Jenkins-Webhook.jpg")
}

resource "aws_s3_object" "Jenkins-Pipeline" {
  bucket = aws_s3_bucket.public_jenkins_bucket.id
  key    = "Jenkins-Pipeline.jpg"
  source = "${path.module}/screenshots/Jenkins-Pipeline.jpg"
  content_type = "image/jpg"

  etag   = filemd5("${path.module}/screenshots/Jenkins-Pipeline.jpg")
}

resource "aws_s3_object" "s3jenkins" {
  bucket = aws_s3_bucket.public_jenkins_bucket.id
  key    = "s3jenkins.jpg"
  source = "${path.module}/screenshots/s3jenkins.jpg"
  content_type = "image/jpg"

  etag   = filemd5("${path.module}/screenshots/s3jenkins.jpg")
}