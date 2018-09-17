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

variable "subnet_ids" {
  type        = "list"
  description = "List of private subnet IDs Mongo launches in"
}

variable "region" {
  type        = "string"
  description = "AWS region"
  default     = "eu-central-1"
}

variable "vpc_id" {
  type        = "string"
  description = "VPC ID of something we connect to somewhere"
}

variable "vpc_security_group_ids" {
  type        = "list"
  description = "VPC ID security of something we connect to somewhere"
}

##Networking
variable "dns_name" {
  type        = "string"
  description = "Hostname prefix for route53 record creation"
  default     = "mongodb"
}

variable "dns_zone" {
  type        = "string"
  description = "Route 53 zone id to create records in"
}

variable "ami_username" {
  description = "describe your variable"
  default     = "ubuntu"
}

variable "key_name" {
  type        = "string"
  description = "key pair name used with new ec2 instances"
}

variable "key_path" {
  type        = "string"
  description = "key pair used with new ec2 instances"
  default     = "~/.ssh/frankfurt.pem"
}

variable "instance_type" {
  type        = "string"
  description = "AWS EC2 instance type to use for creating cluster nodes"
  default     = "t2.nano"
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

variable "ami_id" {
  type        = "string"
  description = "AMI ID"
}

variable "domain" {
  description = "describe your variable"
  default     = "urbn8.io"
}

variable "replica_set" {
  description = "describe your variable"
  default     = "production-mgo"
}
