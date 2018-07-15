output "security_group_id" {
  value = "${aws_security_group.balancer.id}"
}

output "mongodb-url" {
  value = "${aws_route53_record.mongo.*.fqdn}"
}
