terraform {
  backend "s3" {
    bucket = "terraform-staging-urbn8.io"
    key    = "network/terraform.tfstate"
    region = "eu-central-1"
  }
}

module "vpc" {
  source              = "../../modules/vpc"
  environment         = "staging"
  customer_gateway    = "103.99.244.46"
  domain              = "urbn8.io"
  vpc_cidr            = "172.30.0.0/16"
  vpc_private_subnets = ["172.30.48.0/20", "172.30.64.0/20", "172.30.80.0/20"]
  vpc_public_subnets  = ["172.30.16.0/20", "172.30.0.0/20", "172.30.32.0/20"]
}

module "slack" {
  source                = "../../modules/slack"
  slack_message_deploy  = "Deploy or update the VPC:${module.vpc.vpc_id} at time: ${timestamp()}"
  slack_message_destroy = "Destroy the VPC:${module.vpc.vpc_id} at time: ${timestamp()}"
}
