variable "environment" {
  type        = "string"
  default     = "dev"
  description = "Environment/production tier"
}

variable "ami_username" {
  description = "describe your variable"
  default     = "ubuntu"
}

variable "key_name" {
  default     = "thientran"
  type        = "string"
  description = "key pair name used with new ec2 instances"
}

variable "public_key_path" {
  description = <<DESCRIPTION
Path to the SSH public key to be used for authentication.
Ensure this keypair is added to your local SSH agent so provisioners can
connect.
Example: ~/.ssh/terraform.pub
DESCRIPTION

  default = "./../secret/nfq.pub"
}

variable "instance_type" {
  type        = "string"
  description = "AWS EC2 instance type to use for creating cluster nodes"
  default     = "t3.small"
}
