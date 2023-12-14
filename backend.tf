terraform {
  backend "s3" {
    bucket = "ter-info"
    key    = "terraform/information"
    region = "us-east-1"
  }
}