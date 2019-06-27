# This file will be replaced when running test

provider "aws"{
  region = "ap-southeast-1"
}

terraform {
  backend "local" {
    path =  "test.tfstate"
  }
}
