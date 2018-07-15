variable "aws_region" {
  description = "Region for the VPC"
  default = "eu-central-1"
}
variable "zones" {
  description = "Available zone"
  default = ["eu-central-1a", "eu-central-1b", "eu-central-1c"]
}

variable "s3_bucket" {
  description = "Your bucket"
}

variable "environment" {
  description = "Your environment"
}

variable "domain" {
	description = "Your domain"
}
variable "prevent_destroy_s3" {
	default = 1
}
