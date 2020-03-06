data "terraform_remote_state" "base_network" {
  backend = "s3"
  config = {
    bucket = "demo-eks"
    key    = "provision/base-network.tfstate"
    region = "ap-southeast-1"
  }
}

data "terraform_remote_state" "base_ami" {
  backend = "s3"
  config = {
    bucket = "demo-eks"
    key    = "provision/base-ami.tfstate"
    region = "ap-southeast-1"
  }
}
