terraform {
  backend "s3" {
    bucket = "terraform-staging-urbn8.io"
    key    = "kubernetes/terraform.tfstate"
    region = "eu-central-1"
  }
}


module "slack" {
	source = "../../modules/slack"
	slack_message_deploy = "Deploy or update the kubernetes at time: ${timestamp()}"
	slack_message_destroy = "Destroy the kubernetes at time: ${timestamp()}"

}