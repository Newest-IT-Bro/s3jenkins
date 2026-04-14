terraform {
    backend "s3" {
    bucket  = "s3jenkins-tfstate"
    key     = "s3-jenkins-test.tfstate"
    region  = "eu-west-2"
    encrypt = true
  }
}
