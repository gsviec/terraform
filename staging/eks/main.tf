provider "aws" {
  version = ">= 1.24.0"
  region  = "${var.region}"
}

data "aws_availability_zones" "available" {}

locals {
  cluster_name = "test-eks-mongo"

  # the commented out worker group list below shows an example of how to define
  # multiple worker groups of differing configurations
  # worker_groups = "${list(
  #                   map("asg_desired_capacity", "2",
  #                       "asg_max_size", "10",
  #                       "asg_min_size", "2",
  #                       "instance_type", "m4.xlarge",
  #                       "name", "worker_group_a",
  #                       "subnets", "${join(",", module.vpc.private_subnets)}",
  #                   ),
  #                   map("asg_desired_capacity", "1",
  #                       "asg_max_size", "5",
  #                       "asg_min_size", "1",
  #                       "instance_type", "m4.2xlarge",
  #                       "name", "worker_group_b",
  #                       "subnets", "${join(",", module.vpc.private_subnets)}",
  #                   ),
  # )}"

  worker_groups = "${list(
                  map(
                      "asg_desired_capacity", "2",
                      "asg_max_size", "3",
                      "asg_min_size", "2",
                      "instance_type","t2.small",
                      "additional_userdata","echo foo bar",
                      "subnets", "${join(",", var.subnets)}",
                      ),

  )}"
  tags = "${map("Environment", "test",
                "GithubRepo", "terraform-aws-eks",
                "GithubOrg", "terraform-aws-modules",
                "Workspace", "${terraform.workspace}",
  )}"
}

module "eks" {
  source             = "terraform-aws-modules/eks/aws"
  cluster_name       = "${local.cluster_name}"
  subnets            = "${var.subnets}"
  tags               = "${local.tags}"
  vpc_id             = "${var.vpc_id}"
  worker_groups      = "${local.worker_groups}"
  worker_group_count = "1"
  map_roles          = "${var.map_roles}"
  map_users          = "${var.map_users}"
  map_accounts       = "${var.map_accounts}"
}
