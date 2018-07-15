resource "aws_security_group" "sg-office" {
  name        = "Prod-office-access"
  description = "Allow office to connect to aws resources"

  ingress {
    from_port   = 0
    to_port     = 65535
    protocol    = "tcp"
    cidr_blocks = "${var.office-subnets}"
  }

  ingress {
    from_port   = 22
    to_port     = 22
    protocol    = "tcp"
    cidr_blocks = "${var.office-static}"
  }

  egress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }

  vpc_id = "${aws_vpc.default.id}"

  tags {
    Name              = "Prod-office-access"
    Infra             = "${var.domain}"
    Environment       = "${var.environment}"
    Terraformed       = "true"
    KubernetesCluster = "${var.environment}.${var.domain}"
  }
}

resource "aws_security_group" "sg-public" {
  name        = "PublicAccessProduction"
  description = "Allow incoming HTTP connections"

  ingress {
    from_port   = 80
    to_port     = 80
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }

  ingress {
    from_port   = 443
    to_port     = 443
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }

  ingress {
    from_port   = -1
    to_port     = -1
    protocol    = "icmp"
    cidr_blocks = ["0.0.0.0/0"]
  }

  vpc_id = "${aws_vpc.default.id}"

  tags {
    Name              = "PublicAccessProduction"
    Infra             = "${var.domain}"
    Environment       = "${var.environment}"
    Terraformed       = "true"
    KubernetesCluster = "${var.environment}.${var.domain}"
  }
}

resource "aws_security_group" "sg-default" {
  name        = "Prod-default"
  description = "Using for internal connection on vpc"

  ingress {
    from_port   = 0
    to_port     = 65535
    protocol    = "tcp"
    cidr_blocks = "${var.vpc_public_subnets}"
  }

  ingress {
    from_port   = 5672
    to_port     = 5672
    protocol    = "tcp"
    cidr_blocks = "${var.storm-clutser-subnets}"
  }

  vpc_id = "${aws_vpc.default.id}"

  tags {
    Name              = "Prod-default"
    Infra             = "${var.domain}"
    Environment       = "${var.environment}"
    Terraformed       = "true"
    KubernetesCluster = "${var.environment}.${var.domain}"
  }
}

resource "aws_security_group" "sg-db" {
  name        = "prod-databases-clusters"
  description = "Allow traffic from public and private subnet access database"

  ingress {
    from_port   = 6379
    to_port     = 6379
    protocol    = "tcp"
    cidr_blocks = "${var.vpc_public_subnets}"
    description = "redis"
  }

  ingress {
    from_port   = 6379
    to_port     = 6379
    protocol    = "tcp"
    cidr_blocks = "${var.vpc_private_subnets}"
    description = "redis"
  }

  ingress {
    from_port   = 5672
    to_port     = 5672
    protocol    = "tcp"
    cidr_blocks = "${var.vpc_public_subnets}"
    description = "rabbitmp"
  }

  ingress {
    from_port   = 5672
    to_port     = 5672
    protocol    = "tcp"
    cidr_blocks = "${var.vpc_private_subnets}"
    description = "rabbitmp"
  }

  ingress {
    from_port   = 27017
    to_port     = 27017
    protocol    = "tcp"
    cidr_blocks = "${var.vpc_public_subnets}"
    description = "mongodb"
  }

  ingress {
    from_port   = 27017
    to_port     = 27017
    protocol    = "tcp"
    cidr_blocks = "${var.vpc_private_subnets}"
    description = "mogodb"
  }

  ingress {
    from_port   = 8500
    to_port     = 8500
    protocol    = "tcp"
    cidr_blocks = "${var.vpc_public_subnets}"
    description = "consul"
  }

  ingress {
    from_port   = 8500
    to_port     = 8500
    protocol    = "tcp"
    cidr_blocks = "${var.vpc_private_subnets}"
    description = "consul"
  }

  ingress {
    from_port   = 9200
    to_port     = 9200
    protocol    = "tcp"
    cidr_blocks = "${var.vpc_public_subnets}"
    description = "elasticsearch"
  }

  ingress {
    from_port   = 9200
    to_port     = 9200
    protocol    = "tcp"
    cidr_blocks = "${var.vpc_private_subnets}"
    description = "elasticsearch"
  }

  ingress {
    from_port   = -1
    to_port     = -1
    protocol    = "icmp"
    cidr_blocks = "${var.vpc_public_subnets}"
  }

  vpc_id = "${aws_vpc.default.id}"

  tags {
    Name              = "Prod-databases-clusters"
    Infra             = "${var.domain}"
    Environment       = "${var.environment}"
    Terraformed       = "true"
    KubernetesCluster = "${var.environment}.${var.domain}"
  }
}
