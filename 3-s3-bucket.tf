resource "aws_s3_bucket" "public_jenkins_bucket" {
  bucket = "s3jenkins-bucket-tester"
  force_destroy = true
}

resource "aws_s3_bucket_versioning" "public_jenkins_versioning" {
  bucket = aws_s3_bucket.public_jenkins_bucket.id
  versioning_configuration {
    status = "Enabled"
  }
}

resource "aws_s3_bucket_server_side_encryption_configuration" "public_jenkins_encryption" {
  bucket = aws_s3_bucket.public_jenkins_bucket.id

  rule {
    apply_server_side_encryption_by_default {
      sse_algorithm = "AES256"
    }
  }
}

resource "aws_s3_bucket_public_access_block" "public_jenkins_pab" {
  bucket = aws_s3_bucket.public_jenkins_bucket.id

  block_public_acls       = true
  block_public_policy     = true
  ignore_public_acls      = true
  restrict_public_buckets = true
}

resource "aws_s3_bucket_lifecycle_configuration" "public_jenkins_lifecycle" {
  bucket = aws_s3_bucket.public_jenkins_bucket.id

  rule {
    id     = "delete-old-versions"
    status = "Enabled"

    noncurrent_version_expiration {
      noncurrent_days = 7
    }
  }
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

resource "aws_s3_object" "webhook" {
  bucket = aws_s3_bucket.public_jenkins_bucket.id
  key    = "webhook.jpg"
  source = "${path.module}/screenshots/webhook.jpg"
  content_type = "image/jpg"

  etag   = filemd5("${path.module}/screenshots/webhook.jpg")
}

resource "aws_s3_object" "s3jenkins" {
  bucket = aws_s3_bucket.public_jenkins_bucket.id
  key    = "s3jenkins.jpg"
  source = "${path.module}/screenshots/s3jenkins.jpg"
  content_type = "image/jpg"

  etag   = filemd5("${path.module}/screenshots/s3jenkins.jpg")
}