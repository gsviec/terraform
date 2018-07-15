terraform {
  backend "s3" {
    bucket = "gsviec-terraform-dev"
    key    = "kubernetes/terraform.tfstate"
    region = "eu-central-1"
  }
}

# #Only work for the first time to create s3 to store kops state
# module "s3" {
#   source = "../../modules/s3"
#   environment = "dev"
#   domain = "phanbook.com"
#   s3_bucket="kubernetes-dev-phanbook.com"
# }

module "slack" {
	source = "../../modules/slack"
	slack_message_deploy = "Deploy or update the kubernetes at time: ${timestamp()}"
	slack_message_destroy = "Destroy the kubernetes at time: ${timestamp()}"

}