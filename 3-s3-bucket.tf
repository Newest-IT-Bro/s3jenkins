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

  block_public_acls       = false
  block_public_policy     = false
  ignore_public_acls      = false
  restrict_public_buckets = false
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


resource "aws_s3_object" "Armageddon-readme" {
  bucket = aws_s3_bucket.public_jenkins_bucket.id
  key    = "Armageddon-readme.md"
  source = "${path.module}/Armageddon-readme.md"
  content_type = "text/markdown"
  tags   = filemd5("${path.module}/Armageddon-readme.md")
}

resource "aws_s3_object" "extension" {
  bucket = aws_s3_bucket.public_jenkins_bucket.id
  key    = "files/screenshots/extension.png"
  source = "${path.module}/screenshots/extension.png"
  content_type = "image/png"
  tags   = filemd5("${path.module}/screenshots/extension.png")
}

resource "aws_s3_object" "tempproceed" {
  bucket = aws_s3_bucket.public_jenkins_bucket.id
  key    = "files/screenshots/tempproceed.png"
  source = "${path.module}/screenshots/tempproceed.png"
  content_type = "image/png"
  tags   = filemd5("${path.module}/screenshots/tempproceed.png")
}

resource "aws_s3_object" "s3jenkins" {
  bucket = aws_s3_bucket.public_jenkins_bucket.id
  key    = "files/screenshots/s3jenkins.png"
  source = "${path.module}/screenshots/s3jenkins.png"
  content_type = "image/png"
  tags   = filemd5("${path.module}/screenshots/s3jenkins.png")
}