provider "aws" {
  region = "${var.region}"
}

provider "random" {
  version = "~> 1.0"
}

provider "template" {
  version = "~> 1.0"
}
