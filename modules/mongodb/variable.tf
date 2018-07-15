variable "cluster_size" {
  type        = "string"
  default     = "3"
  description = "Number of instances in the mongo cluster"
}

variable "environment" {
  type        = "string"
  default     = "dev"
  description = "Environment/production tier"
}

variable "private_subnets" {
  type        = "list"
  default     = ["subnet-36fff85d", "subnet-c30b76be", "subnet-58145715"]
  description = "List of private subnet IDs Mongo launches in"
}

variable "region" {
  type        = "string"
  description = "AWS region"
  default     = "eu-central-1"
}

variable "vpc_id" {
  type        = "string"
  default     = "vpc-be0353d5"
  description = "VPC ID of something we connect to somewhere"
}

##Networking
variable "dns_name" {
  type        = "string"
  description = "Hostname prefix for route53 record creation"
  default     = "mongodb-elb"
}

variable "dns_zone" {
  type        = "string"
  default     = "Z28IYATELF0OPV"
  description = "Route 53 zone id to create records in"
}

variable "mongo_security_group" {
  type        = "list"
  default     = ["sg-5e6fb632", "sg-c272abae"]
  description = "list of security group ids to grant mongo access"
}

variable "ssh_security_group" {
  type        = "list"
  default     = ["sg-5e6fb632", "sg-c272abae"]
  description = "list of security group ids to grant ssh access"
}

## App
variable "bastion_security_group" {
  type        = "string"
  default     = "sg-c272abae"
  description = "Security group allowing access from Bastion host"
}

variable "key_name" {
  type        = "string"
  default     = "frankuft"
  description = "key pair name used with new ec2 instances"
}

variable "instance_type" {
  type        = "string"
  description = "AWS EC2 instance type to use for creating cluster nodes"
  default     = "t2.nano"
}

variable "replica_set_name" {
  type = "map"

  default = {
    "dev"     = "mongo-rs"
    "staging" = "mongo-rs"
  }

  description = "Mongo replica set name"
}

variable "root_vol_size" {
  type        = "string"
  description = "Space (in Gigabytes) to give to the instance root disk"
  default     = "8"
}

variable "vol_size" {
  type        = "string"
  description = "Space (in Gigabytes) to give to MongoDB"
  default     = "20"
}

variable "domain" {
  description = "describe your variable"
  default     = "urbn8.io"
}
