output "vpc_id" {
  description = "The ID of the VPC"
  value = "${aws_vpc.default.id}"
}

output "vpc_cidr_block" {
  description = "The CIDR block of the VPC"
  value       = "${element(concat(aws_vpc.default.*.cidr_block, list("")), 0)}"
}

output "default_security_group_id" {
  description = "The ID of the security group created by default on VPC creation"
  value       = "${element(concat(aws_vpc.default.*.default_security_group_id, list("")), 0)}"
}

output "default_network_acl_id" {
  description = "The ID of the default network ACL"
  value       = "${element(concat(aws_vpc.default.*.default_network_acl_id, list("")), 0)}"
}

output "default_route_table_id" {
  description = "The ID of the default route table"
  value       = "${element(concat(aws_vpc.default.*.default_route_table_id, list("")), 0)}"
}

output "vpc_instance_tenancy" {
  description = "Tenancy of instances spin up within VPC"
  value       = "${element(concat(aws_vpc.default.*.instance_tenancy, list("")), 0)}"
}

output "vpc_enable_dns_support" {
  description = "Whether or not the VPC has DNS support"
  value       = "${element(concat(aws_vpc.default.*.enable_dns_support, list("")), 0)}"
}

output "vpc_enable_dns_hostnames" {
  description = "Whether or not the VPC has DNS hostname support"
  value       = "${element(concat(aws_vpc.default.*.enable_dns_hostnames, list("")), 0)}"
}
output "vpc_main_route_table_id" {
  description = "The ID of the main route table associated with this VPC"
  value       = "${element(concat(aws_vpc.default.*.main_route_table_id, list("")), 0)}"
}
# Internet Gateway
output "igw_id" {
  description = "The ID of the Internet Gateway"
  value       = "${element(concat(aws_internet_gateway.gw.*.id, list("")), 0)}"
}

output "aws_vpn_gateway" {
  value = "${aws_vpn_gateway.vpn_gateway.id}"
}
output "aws_vpn_connect" {
  value = "${aws_vpn_connection.main.id}"
}

output "security_group_id" {
  description = "The ID of the security group"
  value       = "${aws_security_group.sg-office.id},${aws_security_group.sg-public.id},${aws_security_group.sg-default.id},${aws_security_group.sg-db.id}"
}