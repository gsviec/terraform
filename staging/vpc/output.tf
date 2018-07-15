output "vpc_id" {
  description = "The ID of the VPC"
  value = "${module.vpc.vpc_id}"
}

output "vpc_cidr_block" {
  description = "The CIDR block of the VPC"
  value       = "${module.vpc.vpc_cidr_block}"
}

output "default_security_group_id" {
  description = "The ID of the security group created by default on VPC creation"
  value       = "${module.vpc.default_security_group_id}"
}


output "default_route_table_id" {
  description = "The ID of the default route table"
  value       = "${module.vpc.default_route_table_id}"
}

output "vpc_instance_tenancy" {
  description = "Tenancy of instances spin up within VPC"
  value       = "${module.vpc.vpc_instance_tenancy}"
}

output "vpc_enable_dns_support" {
  description = "Whether or not the VPC has DNS support"
  value       = "${module.vpc.vpc_enable_dns_support}"
}

output "vpc_enable_dns_hostnames" {
  description = "Whether or not the VPC has DNS hostname support"
  value       = "${module.vpc.vpc_enable_dns_hostnames}"
}
output "vpc_main_route_table_id" {
  description = "The ID of the main route table associated with this VPC"
  value       = "${module.vpc.vpc_main_route_table_id}"
}
# Internet Gateway
output "igw_id" {
  description = "The ID of the Internet Gateway"
  value       = "${module.vpc.igw_id}"
}

output "aws_vpn_gateway" {
  value = "${module.vpc.aws_vpn_gateway}"
}
output "aws_vpn_connect" {
  value = "${module.vpc.aws_vpn_connect}"
}

output "security_group_id" {
  description = "The ID of the security group"
  value       = "${module.vpc.security_group_id}"
}