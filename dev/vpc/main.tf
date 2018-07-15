terraform {
  backend "s3" {
    bucket = "gsviec-terraform-dev"
    key    = "network/terraform.tfstate"
    region = "eu-central-1"
  }
}

module "vpc" {
  source = "../../modules/vpc"
  environment = "dev"
  customer_gateway = "103.99.244.45"
  domain = "phanbook.com"
}

module "slack" {
	source = "../../modules/slack"
	slack_message_deploy = "Deploy or update the VPC:${module.vpc.vpc_id} at time: ${timestamp()}"
	slack_message_destroy = "Destroy the VPC:${module.vpc.vpc_id} at time: ${timestamp()}"

}