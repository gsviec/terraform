# variable "public_key_path" {
#   description = <<DESCRIPTION
# Path to the SSH public key to be used for authentication.
# Ensure this keypair is added to your local SSH agent so provisioners can
# connect.
# Example: ~/.ssh/terraform.pub
# DESCRIPTION
# }

variable "aws_region" {
  description = "Region for the VPC"
  default = "eu-central-1"
}

# Ubuntu Precise 16.04 LTS (x64)
variable "aws_amis" {
  default = {
    eu-west-1 = "ami-674cbc1e"
    us-east-1 = "ami-a4dc46db"
    us-west-1 = "ami-969ab1f6"
    us-west-2 = "ami-8803e0f0"
    eu-central-1= "ami-c7e0c82c"
  }
}

variable "vpc_cidr" {
  description = "CIDR for the VPC"
  default = "10.0.0.0/16"
}

variable "zones" {
  description = "Available zone"
  default = ["eu-central-1a", "eu-central-1b", "eu-central-1c"]
}
variable "vpc_private_subnets" {
  default = ["10.10.1.0/24", "10.10.2.0/24", "10.10.3.0/24"]
}
variable "vpc_public_subnets" {
  default = ["10.10.11.0/24", "10.10.12.0/24", "10.10.13.0/24"]
}

variable "key_path" {
  description = "SSH Public Key path"
  default = "~/.ssh/id_rsa.pub"
}
