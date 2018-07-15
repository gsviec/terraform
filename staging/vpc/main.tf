terraform {
  backend "s3" {
    bucket = "terraform-staging-urbn8.io"
    key    = "network/terraform.tfstate"
    region = "eu-central-1"
  }
}

module "vpc" {
  source = "../../modules/vpc"
  environment = "staging"
  customer_gateway = "103.99.244.46"
  domain = "urbn8.io"
}

module "slack" {
	source = "../../modules/slack"
	slack_message_deploy = "Deploy or update the VPC:${module.vpc.vpc_id} at time: ${timestamp()}"
	slack_message_destroy = "Destroy the VPC:${module.vpc.vpc_id} at time: ${timestamp()}"

}