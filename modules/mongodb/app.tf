# Data sources
data "aws_caller_identity" "current" {}

# generate a keyfile for mongo
resource "random_string" "mongo_key" {
  length  = 512
  special = false
}

resource "aws_instance" "mongodb" {
  count         = "${var.cluster_size}"
  ami           = "${var.ami_id}"
  instance_type = "${var.instance_type}"

  vpc_security_group_ids = "${var.vpc_security_group_ids}"

  user_data = "${file("${path.module}/files/attach_ebs.sh")}"
  key_name  = "${var.key_name}"
  subnet_id = "${element(var.subnet_ids, count.index)}"

  root_block_device {
    volume_type = "standard"
    volume_size = "${var.root_vol_size}"
  }

  ebs_block_device {
    device_name = "/dev/xvdg"
    volume_size = "${var.vol_size}"
    volume_type = "gp2"
    encrypted   = "true"
  }

  lifecycle {
    prevent_destroy = false
  }

  tags {
    Name        = "mongodb-${count.index}"
    Infra       = "${var.domain}"
    Environment = "${var.environment}"
    Terraformed = "true"
  }
}

## Config mongodb repicate
resource "null_resource" "configuration" {
  count = "${var.cluster_size}"

  triggers = {
    cluster_instance_ids = "${join(",", aws_instance.mongodb.*.id)}"
  }

  connection {
    host        = "${element(aws_instance.mongodb.*.private_ip, count.index)}"
    user        = "${var.ami_username}"
    private_key = "${file("${var.key_path}")}"
  }

  # copy provisioning files
  provisioner "file" {
    source      = "${path.module}/files"
    destination = "/tmp"
  }

  # copy config files
  # provisioner "file" {
  #   source      = "${template_dir.config.destination_dir}"
  #   destination = "/tmp"
  # }

  # execute scripts
  provisioner "remote-exec" {
    inline = [
      "echo Clusters: ${join(" ", aws_route53_record.mongo.*.fqdn)}",
      "chmod +x /tmp/files/replicate.sh",
      "echo ${count.index} > /tmp/instance-number.txt",
      "/tmp/files/replicate.sh ${var.replica_set} ${join(" ",aws_route53_record.mongo.*.fqdn)}",
    ]
  }
}

resource "aws_route53_record" "mongo" {
  count   = "${var.cluster_size}"
  zone_id = "${var.dns_zone}"
  name    = "${var.dns_name}-${count.index + 1}"
  type    = "A"
  ttl     = 60
  records = ["${element(aws_instance.mongodb.*.private_ip, count.index)}"]
}
