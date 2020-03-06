terraform {
  backend "s3" {
    bucket = "demo-eks"
    key    = "provision/eks.tfstate"
    region = "ap-southeast-1"
  }
}
