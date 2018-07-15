terraform {
  backend "s3" {
    bucket = "gsviec-terraform-dev"
    key    = "mongodb/terraform.tfstate"
    region = "eu-central-1"
  }
}

module "mongodb" {
  source      = "../../modules/mongodb"
  environment = "dev"
  domain      = "phanbook.com"
}

module "slack" {
  source                = "../../modules/slack"
  slack_message_deploy  = "Deploy or update the mongodb at time: ${timestamp()}"
  slack_message_destroy = "Destroy the mongodb at time: ${timestamp()}"
}
