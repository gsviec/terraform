# Define AWS as our provider
provider "aws" {
  region = "${var.aws_region}"
}


# Define our VPC
resource "aws_vpc" "default" {
  cidr_block = "${var.vpc_cidr}"
  enable_dns_hostnames = true

  tags {
    Name = "${var.domain}"
    Infra             = "${var.domain}"
    Environment       = "${var.environment}"
    Terraformed       = "true"
    KubernetesCluster = "${var.environment}.${var.domain}"
  }
}

# Define the public and private subnet Zone A
resource "aws_subnet" "public-subnet-a" {
  vpc_id = "${aws_vpc.default.id}"
  cidr_block = "${var.vpc_public_subnets[0]}"
  availability_zone = "${var.zones[0]}"

  tags {
    Name = "Public Subnet-${var.zones[0]}"
    Infra             = "${var.domain}"
    Environment       = "${var.environment}"
    Terraformed       = "true"
    KubernetesCluster = "${var.environment}.${var.domain}"
  }
}
resource "aws_subnet" "private-subnet-a" {
  vpc_id = "${aws_vpc.default.id}"
  cidr_block = "${var.vpc_private_subnets[0]}"
  availability_zone = "${var.zones[0]}"

  tags {
    Name = "Private Subnet-${var.zones[0]}"
    Infra             = "${var.domain}"
    Environment       = "${var.environment}"
    Terraformed       = "true"
    KubernetesCluster = "${var.environment}.${var.domain}"
  }
}
# Define the public and private subnet Zone B
resource "aws_subnet" "public-subnet-b" {
  vpc_id = "${aws_vpc.default.id}"
  cidr_block = "${var.vpc_public_subnets[1]}"
  availability_zone = "${var.zones[1]}"

  tags {
    Name = "Public Subnet-${var.zones[1]}"
    Infra             = "${var.domain}"
    Environment       = "${var.environment}"
    Terraformed       = "true"
    KubernetesCluster = "${var.environment}.${var.domain}"
  }
}
resource "aws_subnet" "private-subnet-b" {
  vpc_id = "${aws_vpc.default.id}"
  cidr_block = "${var.vpc_private_subnets[1]}"
  availability_zone = "${var.zones[1]}"

  tags {
    Name = "Private Subnet-${var.zones[1]}"
    Infra             = "${var.domain}"
    Environment       = "${var.environment}"
    Terraformed       = "true"
    KubernetesCluster = "${var.environment}.${var.domain}"
  }
}
# Define the public and private subnet Zone C
resource "aws_subnet" "public-subnet-c" {
  vpc_id = "${aws_vpc.default.id}"
  cidr_block = "${var.vpc_public_subnets[2]}"
  availability_zone = "${var.zones[2]}"

  tags {
    Name = "Public Subnet-${var.zones[2]}"
    Infra             = "${var.domain}"
    Environment       = "${var.environment}"
    Terraformed       = "true"
    KubernetesCluster = "${var.environment}.${var.domain}"
  }
}
resource "aws_subnet" "private-subnet-c" {
  vpc_id = "${aws_vpc.default.id}"
  cidr_block = "${var.vpc_private_subnets[2]}"
  availability_zone = "${var.zones[2]}"

  tags {
    Name = "Private Subnet-${var.zones[2]}"
    Infra             = "${var.domain}"
    Environment       = "${var.environment}"
    Terraformed       = "true"
    KubernetesCluster = "${var.environment}.${var.domain}"
  }
}

# Define the internet gateway
resource "aws_internet_gateway" "gw" {
  vpc_id = "${aws_vpc.default.id}"

  tags {
    Name = "VPC-IGW-URBN8"
    Infra             = "${var.domain}"
    Environment       = "${var.environment}"
    Terraformed       = "true"
    KubernetesCluster = "${var.environment}.${var.domain}"
  }
}

# Define the route table
resource "aws_route_table" "web-public-rt" {
  vpc_id = "${aws_vpc.default.id}"

  route {
    cidr_block = "0.0.0.0/0"
    gateway_id = "${aws_internet_gateway.gw.id}"
  }
  route {
    cidr_block = "192.168.9.0/24"
    gateway_id = "${aws_vpn_gateway.vpn_gateway.id}"
  }
  route {
    cidr_block = "192.168.10.0/24"
    gateway_id = "${aws_vpn_gateway.vpn_gateway.id}"
  }

  tags {
    Name = "Public-Subnet-RT"
    Infra             = "${var.domain}"
    Environment       = "${var.environment}"
    Terraformed       = "true"
    KubernetesCluster = "${var.environment}.${var.domain}"
  }
}

# Assign the route table to the public Subnet
resource "aws_route_table_association" "web-public-rt-subnet-a" {
  subnet_id = "${aws_subnet.public-subnet-a.id}"
  route_table_id = "${aws_route_table.web-public-rt.id}"
}
resource "aws_route_table_association" "web-public-rt-subnet-b" {
  subnet_id = "${aws_subnet.public-subnet-b.id}"
  route_table_id = "${aws_route_table.web-public-rt.id}"
}
resource "aws_route_table_association" "web-public-rt-subnet-c" {
  subnet_id = "${aws_subnet.public-subnet-c.id}"
  route_table_id = "${aws_route_table.web-public-rt.id}"
}


#Create Virtual Private Gateway
resource "aws_vpn_gateway" "vpn_gateway" {
  tags {
    Name = "EU-VPN-GW"
    Infra             = "${var.domain}"
    Environment       = "${var.environment}"
    Terraformed       = "true"
    KubernetesCluster = "${var.environment}.${var.domain}"
  }
}

resource "aws_vpn_gateway_attachment" "vpn_attachment" {
  vpc_id         = "${aws_vpc.default.id}"
  vpn_gateway_id = "${aws_vpn_gateway.vpn_gateway.id}"
}


resource "aws_customer_gateway" "customer_gateway" {
  bgp_asn    = 65000
  ip_address = "${var.customer_gateway}"
  type       = "ipsec.1"

  tags {
    Name = "VN_VNPT"
    Infra             = "${var.domain}"
    Environment       = "${var.environment}"
    Terraformed       = "true"
    KubernetesCluster = "${var.environment}.${var.domain}"
  }
}

resource "aws_vpn_connection" "main" {
  vpn_gateway_id      = "${aws_vpn_gateway.vpn_gateway.id}"
  customer_gateway_id = "${aws_customer_gateway.customer_gateway.id}"
  type                = "ipsec.1"
  static_routes_only  = true
  tags {
    Name = "VNOFFICE"
    Infra             = "${var.domain}"
    Environment       = "${var.environment}"
    Terraformed       = "true"
    KubernetesCluster = "${var.environment}.${var.domain}"
  }
}

