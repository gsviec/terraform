output "mongodb-url" {
  value = "${aws_route53_record.mongo.*.fqdn}"
}
