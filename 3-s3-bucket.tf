resource "aws_s3_bucket" "jenkins_bucket" {
  bucket = "s3jenkins-bucket-tester"
  force_destroy = true
}

resource "aws_s3_object" "cloud_file" {
  bucket = aws_s3_bucket.jenkins_bucket.id
  key    = "files/screenshots/cloudsdk.png"
  source = "${path.module}/screenshots/cloudsdk.png"
  etag   = filemd5("${path.module}/screenshots/cloudsdk.png")
}

resource "aws_s3_object" "extension_file" {
  bucket = aws_s3_bucket.jenkins_bucket.id
  key    = "files/screenshots/extension.png"
  source = "${path.module}/screenshots/extension.png"
  etag   = filemd5("${path.module}/screenshots/extension.png")
}

resource "aws_s3_object" "tempproceed_file" {
  bucket = aws_s3_bucket.jenkins_bucket.id
  key    = "files/screenshots/tempproceed.png"
  source = "${path.module}/screenshots/tempproceed.png"
  etag   = filemd5("${path.module}/screenshots/tempproceed.png")
}