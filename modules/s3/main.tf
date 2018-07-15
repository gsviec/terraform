# Define AWS as our provider
provider "aws" {
  region = "${var.aws_region}"
}

resource "aws_s3_bucket" "state_store" {
  bucket        = "${var.s3_bucket}"
  acl           = "private"
  force_destroy = true

  versioning {
    enabled = true
  }
  # lifecycle {
  #   prevent_destroy = true
  # }
  tags {
    Name        = "${var.s3_bucket}-${var.environment}-state-store"
    Infra       = "${var.domain}"
    Environment = "${var.environment}"
    Terraformed = "true"
  }
}