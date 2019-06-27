output "Private_IP" {
  value       = "${aws_instance.web.private_ip}"
  description = "The private IP address of the main server instance."
}

output "Public_IP" {
  value       = "${aws_instance.web.public_ip}"
  description = "The public IP address of the main server instance."
}
