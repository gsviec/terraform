output "cluster_name" {
  value = "staging.urbn8.io"
}

output "master_security_group_ids" {
  value = ["${aws_security_group.masters-staging-urbn8-io.id}"]
}

output "masters_role_arn" {
  value = "${aws_iam_role.masters-staging-urbn8-io.arn}"
}

output "masters_role_name" {
  value = "${aws_iam_role.masters-staging-urbn8-io.name}"
}

output "node_security_group_ids" {
  value = ["${aws_security_group.nodes-staging-urbn8-io.id}"]
}

output "node_subnet_ids" {
  value = ["${aws_subnet.eu-central-1a-staging-urbn8-io.id}", "${aws_subnet.eu-central-1b-staging-urbn8-io.id}", "${aws_subnet.eu-central-1c-staging-urbn8-io.id}"]
}

output "nodes_role_arn" {
  value = "${aws_iam_role.nodes-staging-urbn8-io.arn}"
}

output "nodes_role_name" {
  value = "${aws_iam_role.nodes-staging-urbn8-io.name}"
}

output "region" {
  value = "eu-central-1"
}

output "vpc_id" {
  value = "vpc-23124148"
}

provider "aws" {
  region = "eu-central-1"
}

resource "aws_autoscaling_attachment" "master-eu-central-1a-masters-staging-urbn8-io" {
  elb                    = "${aws_elb.api-staging-urbn8-io.id}"
  autoscaling_group_name = "${aws_autoscaling_group.master-eu-central-1a-masters-staging-urbn8-io.id}"
}

resource "aws_autoscaling_attachment" "master-eu-central-1b-masters-staging-urbn8-io" {
  elb                    = "${aws_elb.api-staging-urbn8-io.id}"
  autoscaling_group_name = "${aws_autoscaling_group.master-eu-central-1b-masters-staging-urbn8-io.id}"
}

resource "aws_autoscaling_attachment" "master-eu-central-1c-masters-staging-urbn8-io" {
  elb                    = "${aws_elb.api-staging-urbn8-io.id}"
  autoscaling_group_name = "${aws_autoscaling_group.master-eu-central-1c-masters-staging-urbn8-io.id}"
}

resource "aws_autoscaling_group" "master-eu-central-1a-masters-staging-urbn8-io" {
  name                 = "master-eu-central-1a.masters.staging.urbn8.io"
  launch_configuration = "${aws_launch_configuration.master-eu-central-1a-masters-staging-urbn8-io.id}"
  max_size             = 1
  min_size             = 1
  vpc_zone_identifier  = ["${aws_subnet.eu-central-1a-staging-urbn8-io.id}"]

  tag = {
    key                 = "KubernetesCluster"
    value               = "staging.urbn8.io"
    propagate_at_launch = true
  }

  tag = {
    key                 = "Name"
    value               = "master-eu-central-1a.masters.staging.urbn8.io"
    propagate_at_launch = true
  }

  tag = {
    key                 = "k8s.io/cluster-autoscaler/node-template/label/kops.k8s.io/instancegroup"
    value               = "master-eu-central-1a"
    propagate_at_launch = true
  }

  tag = {
    key                 = "k8s.io/role/master"
    value               = "1"
    propagate_at_launch = true
  }

  metrics_granularity = "1Minute"
  enabled_metrics     = ["GroupDesiredCapacity", "GroupInServiceInstances", "GroupMaxSize", "GroupMinSize", "GroupPendingInstances", "GroupStandbyInstances", "GroupTerminatingInstances", "GroupTotalInstances"]
}

resource "aws_autoscaling_group" "master-eu-central-1b-masters-staging-urbn8-io" {
  name                 = "master-eu-central-1b.masters.staging.urbn8.io"
  launch_configuration = "${aws_launch_configuration.master-eu-central-1b-masters-staging-urbn8-io.id}"
  max_size             = 1
  min_size             = 1
  vpc_zone_identifier  = ["${aws_subnet.eu-central-1b-staging-urbn8-io.id}"]

  tag = {
    key                 = "KubernetesCluster"
    value               = "staging.urbn8.io"
    propagate_at_launch = true
  }

  tag = {
    key                 = "Name"
    value               = "master-eu-central-1b.masters.staging.urbn8.io"
    propagate_at_launch = true
  }

  tag = {
    key                 = "k8s.io/cluster-autoscaler/node-template/label/kops.k8s.io/instancegroup"
    value               = "master-eu-central-1b"
    propagate_at_launch = true
  }

  tag = {
    key                 = "k8s.io/role/master"
    value               = "1"
    propagate_at_launch = true
  }

  metrics_granularity = "1Minute"
  enabled_metrics     = ["GroupDesiredCapacity", "GroupInServiceInstances", "GroupMaxSize", "GroupMinSize", "GroupPendingInstances", "GroupStandbyInstances", "GroupTerminatingInstances", "GroupTotalInstances"]
}

resource "aws_autoscaling_group" "master-eu-central-1c-masters-staging-urbn8-io" {
  name                 = "master-eu-central-1c.masters.staging.urbn8.io"
  launch_configuration = "${aws_launch_configuration.master-eu-central-1c-masters-staging-urbn8-io.id}"
  max_size             = 1
  min_size             = 1
  vpc_zone_identifier  = ["${aws_subnet.eu-central-1c-staging-urbn8-io.id}"]

  tag = {
    key                 = "KubernetesCluster"
    value               = "staging.urbn8.io"
    propagate_at_launch = true
  }

  tag = {
    key                 = "Name"
    value               = "master-eu-central-1c.masters.staging.urbn8.io"
    propagate_at_launch = true
  }

  tag = {
    key                 = "k8s.io/cluster-autoscaler/node-template/label/kops.k8s.io/instancegroup"
    value               = "master-eu-central-1c"
    propagate_at_launch = true
  }

  tag = {
    key                 = "k8s.io/role/master"
    value               = "1"
    propagate_at_launch = true
  }

  metrics_granularity = "1Minute"
  enabled_metrics     = ["GroupDesiredCapacity", "GroupInServiceInstances", "GroupMaxSize", "GroupMinSize", "GroupPendingInstances", "GroupStandbyInstances", "GroupTerminatingInstances", "GroupTotalInstances"]
}

resource "aws_autoscaling_group" "nodes-staging-urbn8-io" {
  name                 = "nodes.staging.urbn8.io"
  launch_configuration = "${aws_launch_configuration.nodes-staging-urbn8-io.id}"
  max_size             = 3
  min_size             = 3
  vpc_zone_identifier  = ["${aws_subnet.eu-central-1a-staging-urbn8-io.id}", "${aws_subnet.eu-central-1b-staging-urbn8-io.id}", "${aws_subnet.eu-central-1c-staging-urbn8-io.id}"]

  tag = {
    key                 = "KubernetesCluster"
    value               = "staging.urbn8.io"
    propagate_at_launch = true
  }

  tag = {
    key                 = "Name"
    value               = "nodes.staging.urbn8.io"
    propagate_at_launch = true
  }

  tag = {
    key                 = "k8s.io/cluster-autoscaler/node-template/label/kops.k8s.io/instancegroup"
    value               = "nodes"
    propagate_at_launch = true
  }

  tag = {
    key                 = "k8s.io/role/node"
    value               = "1"
    propagate_at_launch = true
  }

  metrics_granularity = "1Minute"
  enabled_metrics     = ["GroupDesiredCapacity", "GroupInServiceInstances", "GroupMaxSize", "GroupMinSize", "GroupPendingInstances", "GroupStandbyInstances", "GroupTerminatingInstances", "GroupTotalInstances"]
}

resource "aws_ebs_volume" "a-etcd-events-staging-urbn8-io" {
  availability_zone = "eu-central-1a"
  size              = 20
  type              = "gp2"
  encrypted         = false

  tags = {
    KubernetesCluster                        = "staging.urbn8.io"
    Name                                     = "a.etcd-events.staging.urbn8.io"
    "k8s.io/etcd/events"                     = "a/a,b,c"
    "k8s.io/role/master"                     = "1"
    "kubernetes.io/cluster/staging.urbn8.io" = "owned"
  }
}

resource "aws_ebs_volume" "a-etcd-main-staging-urbn8-io" {
  availability_zone = "eu-central-1a"
  size              = 20
  type              = "gp2"
  encrypted         = false

  tags = {
    KubernetesCluster                        = "staging.urbn8.io"
    Name                                     = "a.etcd-main.staging.urbn8.io"
    "k8s.io/etcd/main"                       = "a/a,b,c"
    "k8s.io/role/master"                     = "1"
    "kubernetes.io/cluster/staging.urbn8.io" = "owned"
  }
}

resource "aws_ebs_volume" "b-etcd-events-staging-urbn8-io" {
  availability_zone = "eu-central-1b"
  size              = 20
  type              = "gp2"
  encrypted         = false

  tags = {
    KubernetesCluster                        = "staging.urbn8.io"
    Name                                     = "b.etcd-events.staging.urbn8.io"
    "k8s.io/etcd/events"                     = "b/a,b,c"
    "k8s.io/role/master"                     = "1"
    "kubernetes.io/cluster/staging.urbn8.io" = "owned"
  }
}

resource "aws_ebs_volume" "b-etcd-main-staging-urbn8-io" {
  availability_zone = "eu-central-1b"
  size              = 20
  type              = "gp2"
  encrypted         = false

  tags = {
    KubernetesCluster                        = "staging.urbn8.io"
    Name                                     = "b.etcd-main.staging.urbn8.io"
    "k8s.io/etcd/main"                       = "b/a,b,c"
    "k8s.io/role/master"                     = "1"
    "kubernetes.io/cluster/staging.urbn8.io" = "owned"
  }
}

resource "aws_ebs_volume" "c-etcd-events-staging-urbn8-io" {
  availability_zone = "eu-central-1c"
  size              = 20
  type              = "gp2"
  encrypted         = false

  tags = {
    KubernetesCluster                        = "staging.urbn8.io"
    Name                                     = "c.etcd-events.staging.urbn8.io"
    "k8s.io/etcd/events"                     = "c/a,b,c"
    "k8s.io/role/master"                     = "1"
    "kubernetes.io/cluster/staging.urbn8.io" = "owned"
  }
}

resource "aws_ebs_volume" "c-etcd-main-staging-urbn8-io" {
  availability_zone = "eu-central-1c"
  size              = 20
  type              = "gp2"
  encrypted         = false

  tags = {
    KubernetesCluster                        = "staging.urbn8.io"
    Name                                     = "c.etcd-main.staging.urbn8.io"
    "k8s.io/etcd/main"                       = "c/a,b,c"
    "k8s.io/role/master"                     = "1"
    "kubernetes.io/cluster/staging.urbn8.io" = "owned"
  }
}

resource "aws_eip" "eu-central-1a-staging-urbn8-io" {
  vpc = true

  tags = {
    KubernetesCluster                        = "staging.urbn8.io"
    Name                                     = "eu-central-1a.staging.urbn8.io"
    "kubernetes.io/cluster/staging.urbn8.io" = "owned"
  }
}

resource "aws_eip" "eu-central-1b-staging-urbn8-io" {
  vpc = true

  tags = {
    KubernetesCluster                        = "staging.urbn8.io"
    Name                                     = "eu-central-1b.staging.urbn8.io"
    "kubernetes.io/cluster/staging.urbn8.io" = "owned"
  }
}

resource "aws_eip" "eu-central-1c-staging-urbn8-io" {
  vpc = true

  tags = {
    KubernetesCluster                        = "staging.urbn8.io"
    Name                                     = "eu-central-1c.staging.urbn8.io"
    "kubernetes.io/cluster/staging.urbn8.io" = "owned"
  }
}

resource "aws_elb" "api-staging-urbn8-io" {
  name = "api-staging-urbn8-io-mlolug"

  listener = {
    instance_port     = 443
    instance_protocol = "TCP"
    lb_port           = 443
    lb_protocol       = "TCP"
  }

  security_groups = ["${aws_security_group.api-elb-staging-urbn8-io.id}"]
  subnets         = ["${aws_subnet.utility-eu-central-1a-staging-urbn8-io.id}", "${aws_subnet.utility-eu-central-1b-staging-urbn8-io.id}", "${aws_subnet.utility-eu-central-1c-staging-urbn8-io.id}"]

  health_check = {
    target              = "SSL:443"
    healthy_threshold   = 2
    unhealthy_threshold = 2
    interval            = 10
    timeout             = 5
  }

  idle_timeout = 300

  tags = {
    KubernetesCluster = "staging.urbn8.io"
    Name              = "api.staging.urbn8.io"
  }
}

resource "aws_iam_instance_profile" "masters-staging-urbn8-io" {
  name = "masters.staging.urbn8.io"
  role = "${aws_iam_role.masters-staging-urbn8-io.name}"
}

resource "aws_iam_instance_profile" "nodes-staging-urbn8-io" {
  name = "nodes.staging.urbn8.io"
  role = "${aws_iam_role.nodes-staging-urbn8-io.name}"
}

resource "aws_iam_role" "masters-staging-urbn8-io" {
  name               = "masters.staging.urbn8.io"
  assume_role_policy = "${file("${path.module}/data/aws_iam_role_masters.staging.urbn8.io_policy")}"
}

resource "aws_iam_role" "nodes-staging-urbn8-io" {
  name               = "nodes.staging.urbn8.io"
  assume_role_policy = "${file("${path.module}/data/aws_iam_role_nodes.staging.urbn8.io_policy")}"
}

resource "aws_iam_role_policy" "masters-staging-urbn8-io" {
  name   = "masters.staging.urbn8.io"
  role   = "${aws_iam_role.masters-staging-urbn8-io.name}"
  policy = "${file("${path.module}/data/aws_iam_role_policy_masters.staging.urbn8.io_policy")}"
}

resource "aws_iam_role_policy" "nodes-staging-urbn8-io" {
  name   = "nodes.staging.urbn8.io"
  role   = "${aws_iam_role.nodes-staging-urbn8-io.name}"
  policy = "${file("${path.module}/data/aws_iam_role_policy_nodes.staging.urbn8.io_policy")}"
}

resource "aws_key_pair" "kubernetes-staging-urbn8-io-43ae2b34adb7061bc35c0799b8aba937" {
  key_name   = "kubernetes.staging.urbn8.io-43:ae:2b:34:ad:b7:06:1b:c3:5c:07:99:b8:ab:a9:37"
  public_key = "${file("${path.module}/data/aws_key_pair_kubernetes.staging.urbn8.io-43ae2b34adb7061bc35c0799b8aba937_public_key")}"
}

resource "aws_launch_configuration" "master-eu-central-1a-masters-staging-urbn8-io" {
  name_prefix                 = "master-eu-central-1a.masters.staging.urbn8.io-"
  image_id                    = "ami-a92b43c6"
  instance_type               = "t2.micro"
  key_name                    = "${aws_key_pair.kubernetes-staging-urbn8-io-43ae2b34adb7061bc35c0799b8aba937.id}"
  iam_instance_profile        = "${aws_iam_instance_profile.masters-staging-urbn8-io.id}"
  security_groups             = ["${aws_security_group.masters-staging-urbn8-io.id}"]
  associate_public_ip_address = false
  user_data                   = "${file("${path.module}/data/aws_launch_configuration_master-eu-central-1a.masters.staging.urbn8.io_user_data")}"

  root_block_device = {
    volume_type           = "gp2"
    volume_size           = 64
    delete_on_termination = true
  }

  lifecycle = {
    create_before_destroy = true
  }

  enable_monitoring = false
}

resource "aws_launch_configuration" "master-eu-central-1b-masters-staging-urbn8-io" {
  name_prefix                 = "master-eu-central-1b.masters.staging.urbn8.io-"
  image_id                    = "ami-a92b43c6"
  instance_type               = "t2.micro"
  key_name                    = "${aws_key_pair.kubernetes-staging-urbn8-io-43ae2b34adb7061bc35c0799b8aba937.id}"
  iam_instance_profile        = "${aws_iam_instance_profile.masters-staging-urbn8-io.id}"
  security_groups             = ["${aws_security_group.masters-staging-urbn8-io.id}"]
  associate_public_ip_address = false
  user_data                   = "${file("${path.module}/data/aws_launch_configuration_master-eu-central-1b.masters.staging.urbn8.io_user_data")}"

  root_block_device = {
    volume_type           = "gp2"
    volume_size           = 64
    delete_on_termination = true
  }

  lifecycle = {
    create_before_destroy = true
  }

  enable_monitoring = false
}

resource "aws_launch_configuration" "master-eu-central-1c-masters-staging-urbn8-io" {
  name_prefix                 = "master-eu-central-1c.masters.staging.urbn8.io-"
  image_id                    = "ami-a92b43c6"
  instance_type               = "t2.micro"
  key_name                    = "${aws_key_pair.kubernetes-staging-urbn8-io-43ae2b34adb7061bc35c0799b8aba937.id}"
  iam_instance_profile        = "${aws_iam_instance_profile.masters-staging-urbn8-io.id}"
  security_groups             = ["${aws_security_group.masters-staging-urbn8-io.id}"]
  associate_public_ip_address = false
  user_data                   = "${file("${path.module}/data/aws_launch_configuration_master-eu-central-1c.masters.staging.urbn8.io_user_data")}"

  root_block_device = {
    volume_type           = "gp2"
    volume_size           = 64
    delete_on_termination = true
  }

  lifecycle = {
    create_before_destroy = true
  }

  enable_monitoring = false
}

resource "aws_launch_configuration" "nodes-staging-urbn8-io" {
  name_prefix                 = "nodes.staging.urbn8.io-"
  image_id                    = "ami-a92b43c6"
  instance_type               = "t2.medium"
  key_name                    = "${aws_key_pair.kubernetes-staging-urbn8-io-43ae2b34adb7061bc35c0799b8aba937.id}"
  iam_instance_profile        = "${aws_iam_instance_profile.nodes-staging-urbn8-io.id}"
  security_groups             = ["${aws_security_group.nodes-staging-urbn8-io.id}"]
  associate_public_ip_address = false
  user_data                   = "${file("${path.module}/data/aws_launch_configuration_nodes.staging.urbn8.io_user_data")}"

  root_block_device = {
    volume_type           = "gp2"
    volume_size           = 128
    delete_on_termination = true
  }

  lifecycle = {
    create_before_destroy = true
  }

  enable_monitoring = false
}

resource "aws_nat_gateway" "eu-central-1a-staging-urbn8-io" {
  allocation_id = "${aws_eip.eu-central-1a-staging-urbn8-io.id}"
  subnet_id     = "${aws_subnet.utility-eu-central-1a-staging-urbn8-io.id}"

  tags = {
    KubernetesCluster                        = "staging.urbn8.io"
    Name                                     = "eu-central-1a.staging.urbn8.io"
    "kubernetes.io/cluster/staging.urbn8.io" = "owned"
  }
}

resource "aws_nat_gateway" "eu-central-1b-staging-urbn8-io" {
  allocation_id = "${aws_eip.eu-central-1b-staging-urbn8-io.id}"
  subnet_id     = "${aws_subnet.utility-eu-central-1b-staging-urbn8-io.id}"

  tags = {
    KubernetesCluster                        = "staging.urbn8.io"
    Name                                     = "eu-central-1b.staging.urbn8.io"
    "kubernetes.io/cluster/staging.urbn8.io" = "owned"
  }
}

resource "aws_nat_gateway" "eu-central-1c-staging-urbn8-io" {
  allocation_id = "${aws_eip.eu-central-1c-staging-urbn8-io.id}"
  subnet_id     = "${aws_subnet.utility-eu-central-1c-staging-urbn8-io.id}"

  tags = {
    KubernetesCluster                        = "staging.urbn8.io"
    Name                                     = "eu-central-1c.staging.urbn8.io"
    "kubernetes.io/cluster/staging.urbn8.io" = "owned"
  }
}

resource "aws_route" "0-0-0-0--0" {
  route_table_id         = "${aws_route_table.staging-urbn8-io.id}"
  destination_cidr_block = "0.0.0.0/0"
  gateway_id             = "igw-b4aaf3dc"
}

resource "aws_route" "private-eu-central-1a-0-0-0-0--0" {
  route_table_id         = "${aws_route_table.private-eu-central-1a-staging-urbn8-io.id}"
  destination_cidr_block = "0.0.0.0/0"
  nat_gateway_id         = "${aws_nat_gateway.eu-central-1a-staging-urbn8-io.id}"
}

resource "aws_route" "private-eu-central-1b-0-0-0-0--0" {
  route_table_id         = "${aws_route_table.private-eu-central-1b-staging-urbn8-io.id}"
  destination_cidr_block = "0.0.0.0/0"
  nat_gateway_id         = "${aws_nat_gateway.eu-central-1b-staging-urbn8-io.id}"
}

resource "aws_route" "private-eu-central-1c-0-0-0-0--0" {
  route_table_id         = "${aws_route_table.private-eu-central-1c-staging-urbn8-io.id}"
  destination_cidr_block = "0.0.0.0/0"
  nat_gateway_id         = "${aws_nat_gateway.eu-central-1c-staging-urbn8-io.id}"
}

resource "aws_route53_record" "api-staging-urbn8-io" {
  name = "api.staging.urbn8.io"
  type = "A"

  alias = {
    name                   = "${aws_elb.api-staging-urbn8-io.dns_name}"
    zone_id                = "${aws_elb.api-staging-urbn8-io.zone_id}"
    evaluate_target_health = false
  }

  zone_id = "/hostedzone/ZTSLDH58UVUDZ"
}

resource "aws_route_table" "private-eu-central-1a-staging-urbn8-io" {
  vpc_id = "vpc-23124148"

  tags = {
    KubernetesCluster                        = "staging.urbn8.io"
    Name                                     = "private-eu-central-1a.staging.urbn8.io"
    "kubernetes.io/cluster/staging.urbn8.io" = "owned"
    "kubernetes.io/kops/role"                = "private-eu-central-1a"
  }
}

resource "aws_route_table" "private-eu-central-1b-staging-urbn8-io" {
  vpc_id = "vpc-23124148"

  tags = {
    KubernetesCluster                        = "staging.urbn8.io"
    Name                                     = "private-eu-central-1b.staging.urbn8.io"
    "kubernetes.io/cluster/staging.urbn8.io" = "owned"
    "kubernetes.io/kops/role"                = "private-eu-central-1b"
  }
}

resource "aws_route_table" "private-eu-central-1c-staging-urbn8-io" {
  vpc_id = "vpc-23124148"

  tags = {
    KubernetesCluster                        = "staging.urbn8.io"
    Name                                     = "private-eu-central-1c.staging.urbn8.io"
    "kubernetes.io/cluster/staging.urbn8.io" = "owned"
    "kubernetes.io/kops/role"                = "private-eu-central-1c"
  }
}

resource "aws_route_table" "staging-urbn8-io" {
  vpc_id = "vpc-23124148"

  tags = {
    KubernetesCluster                        = "staging.urbn8.io"
    Name                                     = "staging.urbn8.io"
    "kubernetes.io/cluster/staging.urbn8.io" = "owned"
    "kubernetes.io/kops/role"                = "public"
  }
}

resource "aws_route_table_association" "private-eu-central-1a-staging-urbn8-io" {
  subnet_id      = "${aws_subnet.eu-central-1a-staging-urbn8-io.id}"
  route_table_id = "${aws_route_table.private-eu-central-1a-staging-urbn8-io.id}"
}

resource "aws_route_table_association" "private-eu-central-1b-staging-urbn8-io" {
  subnet_id      = "${aws_subnet.eu-central-1b-staging-urbn8-io.id}"
  route_table_id = "${aws_route_table.private-eu-central-1b-staging-urbn8-io.id}"
}

resource "aws_route_table_association" "private-eu-central-1c-staging-urbn8-io" {
  subnet_id      = "${aws_subnet.eu-central-1c-staging-urbn8-io.id}"
  route_table_id = "${aws_route_table.private-eu-central-1c-staging-urbn8-io.id}"
}

resource "aws_route_table_association" "utility-eu-central-1a-staging-urbn8-io" {
  subnet_id      = "${aws_subnet.utility-eu-central-1a-staging-urbn8-io.id}"
  route_table_id = "${aws_route_table.staging-urbn8-io.id}"
}

resource "aws_route_table_association" "utility-eu-central-1b-staging-urbn8-io" {
  subnet_id      = "${aws_subnet.utility-eu-central-1b-staging-urbn8-io.id}"
  route_table_id = "${aws_route_table.staging-urbn8-io.id}"
}

resource "aws_route_table_association" "utility-eu-central-1c-staging-urbn8-io" {
  subnet_id      = "${aws_subnet.utility-eu-central-1c-staging-urbn8-io.id}"
  route_table_id = "${aws_route_table.staging-urbn8-io.id}"
}

resource "aws_security_group" "api-elb-staging-urbn8-io" {
  name        = "api-elb.staging.urbn8.io"
  vpc_id      = "vpc-23124148"
  description = "Security group for api ELB"

  tags = {
    KubernetesCluster                        = "staging.urbn8.io"
    Name                                     = "api-elb.staging.urbn8.io"
    "kubernetes.io/cluster/staging.urbn8.io" = "owned"
  }
}

resource "aws_security_group" "masters-staging-urbn8-io" {
  name        = "masters.staging.urbn8.io"
  vpc_id      = "vpc-23124148"
  description = "Security group for masters"

  tags = {
    KubernetesCluster                        = "staging.urbn8.io"
    Name                                     = "masters.staging.urbn8.io"
    "kubernetes.io/cluster/staging.urbn8.io" = "owned"
  }
}

resource "aws_security_group" "nodes-staging-urbn8-io" {
  name        = "nodes.staging.urbn8.io"
  vpc_id      = "vpc-23124148"
  description = "Security group for nodes"

  tags = {
    KubernetesCluster                        = "staging.urbn8.io"
    Name                                     = "nodes.staging.urbn8.io"
    "kubernetes.io/cluster/staging.urbn8.io" = "owned"
  }
}

resource "aws_security_group_rule" "all-master-to-master" {
  type                     = "ingress"
  security_group_id        = "${aws_security_group.masters-staging-urbn8-io.id}"
  source_security_group_id = "${aws_security_group.masters-staging-urbn8-io.id}"
  from_port                = 0
  to_port                  = 0
  protocol                 = "-1"
}

resource "aws_security_group_rule" "all-master-to-node" {
  type                     = "ingress"
  security_group_id        = "${aws_security_group.nodes-staging-urbn8-io.id}"
  source_security_group_id = "${aws_security_group.masters-staging-urbn8-io.id}"
  from_port                = 0
  to_port                  = 0
  protocol                 = "-1"
}

resource "aws_security_group_rule" "all-node-to-node" {
  type                     = "ingress"
  security_group_id        = "${aws_security_group.nodes-staging-urbn8-io.id}"
  source_security_group_id = "${aws_security_group.nodes-staging-urbn8-io.id}"
  from_port                = 0
  to_port                  = 0
  protocol                 = "-1"
}

resource "aws_security_group_rule" "api-elb-egress" {
  type              = "egress"
  security_group_id = "${aws_security_group.api-elb-staging-urbn8-io.id}"
  from_port         = 0
  to_port           = 0
  protocol          = "-1"
  cidr_blocks       = ["0.0.0.0/0"]
}

resource "aws_security_group_rule" "https-api-elb-0-0-0-0--0" {
  type              = "ingress"
  security_group_id = "${aws_security_group.api-elb-staging-urbn8-io.id}"
  from_port         = 443
  to_port           = 443
  protocol          = "tcp"
  cidr_blocks       = ["0.0.0.0/0"]
}

resource "aws_security_group_rule" "https-elb-to-master" {
  type                     = "ingress"
  security_group_id        = "${aws_security_group.masters-staging-urbn8-io.id}"
  source_security_group_id = "${aws_security_group.api-elb-staging-urbn8-io.id}"
  from_port                = 443
  to_port                  = 443
  protocol                 = "tcp"
}

resource "aws_security_group_rule" "master-egress" {
  type              = "egress"
  security_group_id = "${aws_security_group.masters-staging-urbn8-io.id}"
  from_port         = 0
  to_port           = 0
  protocol          = "-1"
  cidr_blocks       = ["0.0.0.0/0"]
}

resource "aws_security_group_rule" "node-egress" {
  type              = "egress"
  security_group_id = "${aws_security_group.nodes-staging-urbn8-io.id}"
  from_port         = 0
  to_port           = 0
  protocol          = "-1"
  cidr_blocks       = ["0.0.0.0/0"]
}

resource "aws_security_group_rule" "node-to-master-tcp-1-2379" {
  type                     = "ingress"
  security_group_id        = "${aws_security_group.masters-staging-urbn8-io.id}"
  source_security_group_id = "${aws_security_group.nodes-staging-urbn8-io.id}"
  from_port                = 1
  to_port                  = 2379
  protocol                 = "tcp"
}

resource "aws_security_group_rule" "node-to-master-tcp-2382-4000" {
  type                     = "ingress"
  security_group_id        = "${aws_security_group.masters-staging-urbn8-io.id}"
  source_security_group_id = "${aws_security_group.nodes-staging-urbn8-io.id}"
  from_port                = 2382
  to_port                  = 4000
  protocol                 = "tcp"
}

resource "aws_security_group_rule" "node-to-master-tcp-4003-65535" {
  type                     = "ingress"
  security_group_id        = "${aws_security_group.masters-staging-urbn8-io.id}"
  source_security_group_id = "${aws_security_group.nodes-staging-urbn8-io.id}"
  from_port                = 4003
  to_port                  = 65535
  protocol                 = "tcp"
}

resource "aws_security_group_rule" "node-to-master-udp-1-65535" {
  type                     = "ingress"
  security_group_id        = "${aws_security_group.masters-staging-urbn8-io.id}"
  source_security_group_id = "${aws_security_group.nodes-staging-urbn8-io.id}"
  from_port                = 1
  to_port                  = 65535
  protocol                 = "udp"
}

resource "aws_security_group_rule" "ssh-external-to-master-0-0-0-0--0" {
  type              = "ingress"
  security_group_id = "${aws_security_group.masters-staging-urbn8-io.id}"
  from_port         = 22
  to_port           = 22
  protocol          = "tcp"
  cidr_blocks       = ["0.0.0.0/0"]
}

resource "aws_security_group_rule" "ssh-external-to-node-0-0-0-0--0" {
  type              = "ingress"
  security_group_id = "${aws_security_group.nodes-staging-urbn8-io.id}"
  from_port         = 22
  to_port           = 22
  protocol          = "tcp"
  cidr_blocks       = ["0.0.0.0/0"]
}

resource "aws_subnet" "eu-central-1a-staging-urbn8-io" {
  vpc_id            = "vpc-23124148"
  cidr_block        = "172.31.96.0/20"
  availability_zone = "eu-central-1a"

  tags = {
    KubernetesCluster                        = "staging.urbn8.io"
    Name                                     = "eu-central-1a.staging.urbn8.io"
    SubnetType                               = "Private"
    "kubernetes.io/cluster/staging.urbn8.io" = "owned"
    "kubernetes.io/role/internal-elb"        = "1"
  }
}

resource "aws_subnet" "eu-central-1b-staging-urbn8-io" {
  vpc_id            = "vpc-23124148"
  cidr_block        = "172.31.112.0/20"
  availability_zone = "eu-central-1b"

  tags = {
    KubernetesCluster                        = "staging.urbn8.io"
    Name                                     = "eu-central-1b.staging.urbn8.io"
    SubnetType                               = "Private"
    "kubernetes.io/cluster/staging.urbn8.io" = "owned"
    "kubernetes.io/role/internal-elb"        = "1"
  }
}

resource "aws_subnet" "eu-central-1c-staging-urbn8-io" {
  vpc_id            = "vpc-23124148"
  cidr_block        = "172.31.128.0/20"
  availability_zone = "eu-central-1c"

  tags = {
    KubernetesCluster                        = "staging.urbn8.io"
    Name                                     = "eu-central-1c.staging.urbn8.io"
    SubnetType                               = "Private"
    "kubernetes.io/cluster/staging.urbn8.io" = "owned"
    "kubernetes.io/role/internal-elb"        = "1"
  }
}

resource "aws_subnet" "utility-eu-central-1a-staging-urbn8-io" {
  vpc_id            = "vpc-23124148"
  cidr_block        = "172.31.144.0/20"
  availability_zone = "eu-central-1a"

  tags = {
    KubernetesCluster                        = "staging.urbn8.io"
    Name                                     = "utility-eu-central-1a.staging.urbn8.io"
    SubnetType                               = "Utility"
    "kubernetes.io/cluster/staging.urbn8.io" = "owned"
    "kubernetes.io/role/elb"                 = "1"
  }
}

resource "aws_subnet" "utility-eu-central-1b-staging-urbn8-io" {
  vpc_id            = "vpc-23124148"
  cidr_block        = "172.31.160.0/20"
  availability_zone = "eu-central-1b"

  tags = {
    KubernetesCluster                        = "staging.urbn8.io"
    Name                                     = "utility-eu-central-1b.staging.urbn8.io"
    SubnetType                               = "Utility"
    "kubernetes.io/cluster/staging.urbn8.io" = "owned"
    "kubernetes.io/role/elb"                 = "1"
  }
}

resource "aws_subnet" "utility-eu-central-1c-staging-urbn8-io" {
  vpc_id            = "vpc-23124148"
  cidr_block        = "172.31.176.0/20"
  availability_zone = "eu-central-1c"

  tags = {
    KubernetesCluster                        = "staging.urbn8.io"
    Name                                     = "utility-eu-central-1c.staging.urbn8.io"
    SubnetType                               = "Utility"
    "kubernetes.io/cluster/staging.urbn8.io" = "owned"
    "kubernetes.io/role/elb"                 = "1"
  }
}

terraform = {
  required_version = ">= 0.9.3"
}
