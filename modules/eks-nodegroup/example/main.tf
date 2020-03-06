locals {
  cluster_name = data.terraform_remote_state.base_network.outputs.cluster_name
  project_name = data.terraform_remote_state.base_network.outputs.project_name
  environment  = "dev"
}

module "eks" {
  source       = "../"
  project_name = "${local.project_name}"
  environment  = "${local.environment}"
  cluster_name = "${local.cluster_name}"
  vpc_id       = data.terraform_remote_state.base_network.outputs.vpc_id

  #endpoint_private_access = true
  #endpoint_public_access  = false

  hosted_zone_id = data.terraform_remote_state.base_network.outputs.route53_internal_zone_id[0]
  subnet_ids     = data.terraform_remote_state.base_network.outputs.public_subnet
  disk_size      = 30

  labels = {
    "name" = join("-", [local.project_name, local.environment, local.cluster_name])
  }


  # node_groups = {
  #   "g1" = {
  #     node_group_name = "group1"
  #     disk_size       = 30
  #     instance_types  = ["t3.small"]
  #     desired_size    = "2"
  #     min_size        = "2"
  #     max_size        = "5"
  #   }
  #   "g2" = {
  #     node_group_name = "group2"
  #     disk_size       = 20
  #     instance_types  = ["t3.medium"]
  #     desired_size    = "1"
  #     min_size        = "1"
  #     max_size        = "3"
  #   }
  # }
  node_groups = {
    "g1" = {
      node_group_name = "group1"
      disk_size       = 20
      instance_types  = ["t3.small"]
      desired_size    = "2"
      min_size        = "2"
      max_size        = "5"
    }
  }
  enabled_cluster_log_types    = ["api", "audit", "controllerManager", "scheduler", "authenticator"]
  cluster_log_retention_period = 7
  #ami_release_version          = "1.14.8-20191213"

  #data.terraform_remote_state.base_ami.outputs.eks_ami_id
  #version         = kubernetes_version

  node_tags = {
    "Name"                                            = join("-", [local.project_name, local.environment, local.cluster_name])
    "kubernetes.io/cluster/${local.cluster_name}"     = "owned"
    "k8s.io/cluster-autoscaler/${local.cluster_name}" = "owned"
    "k8s.io/cluster-autoscaler/enabled"               = true
  }
  cluster_tags = {
    "Name" = join("-", [local.project_name, local.environment, local.cluster_name])
  }
  kubernetes_labels = {
    "Test" = "acb"
    "Name" = join("-", [local.project_name, local.environment, local.cluster_name])
  }
}
