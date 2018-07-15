terraform {
  backend "s3" {
    bucket = "terraform-staging-urbn8.io"
    key    = "mongodb/terraform.tfstate"
    region = "eu-central-1"
  }
}

module "mongodb" {
  source                 = "../../modules/mongodb"
  environment            = "staging"
  domain                 = "urbn8.io"
  vpc_id                 = "vpc-23124148"
  dns_zone               = "ZTSLDH58UVUDZ"
  mongo_security_group   = ["sg-8d9c46e1", "sg-6192480d"]
  ssh_security_group     = ["sg-6192480d"]
  bastion_security_group = "sg-8d9c46e1"
  key_name               = "frankfurt"
  private_subnets        = ["subnet-58494f33", "subnet-5166251c", "subnet-afbec3d2"]
  vol_size               = "10"
}

module "slack" {
  source                = "../../modules/slack"
  slack_message_deploy  = "Deploy or update the mongodb at time: ${timestamp()}"
  slack_message_destroy = "Destroy the mongodb at time: ${timestamp()}"
}

output "mongodb-url" {
  value = "${module.mongodb.mongodb-url}"
}
