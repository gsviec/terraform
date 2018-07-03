
# Define our VPC
resource "aws_vpc" "default" {
  cidr_block = "${var.vpc_cidr}"
  enable_dns_hostnames = true

  tags {
    Name = "urbn8-vpc"
  }
}

# Define the public and private subnet Zone A
resource "aws_subnet" "public-subnet-a" {
  vpc_id = "${aws_vpc.default.id}"
  cidr_block = "${var.vpc_public_subnets[0]}"
  availability_zone = "${var.zones[0]}"

  tags {
    Name = "Web Public Subnet-${var.zones[0]}"
  }
}
resource "aws_subnet" "private-subnet-a" {
  vpc_id = "${aws_vpc.default.id}"
  cidr_block = "${var.vpc_private_subnets[0]}"
  availability_zone = "${var.zones[0]}"

  tags {
    Name = "Database Private Subnet-${var.zones[0]}"
  }
}
# Define the public and private subnet Zone B
resource "aws_subnet" "public-subnet-b" {
  vpc_id = "${aws_vpc.default.id}"
  cidr_block = "${var.vpc_public_subnets[1]}"
  availability_zone = "${var.zones[1]}"

  tags {
    Name = "Web Public Subnet-${var.zones[1]}"
  }
}
resource "aws_subnet" "private-subnet-b" {
  vpc_id = "${aws_vpc.default.id}"
  cidr_block = "${var.vpc_private_subnets[1]}"
  availability_zone = "${var.zones[1]}"

  tags {
    Name = "Database Private Subnet-${var.zones[1]}"
  }
}
# Define the public and private subnet Zone C
resource "aws_subnet" "public-subnet-c" {
  vpc_id = "${aws_vpc.default.id}"
  cidr_block = "${var.vpc_public_subnets[2]}"
  availability_zone = "${var.zones[2]}"

  tags {
    Name = "Web Public Subnet-${var.zones[2]}"
  }
}
resource "aws_subnet" "private-subnet-c" {
  vpc_id = "${aws_vpc.default.id}"
  cidr_block = "${var.vpc_private_subnets[2]}"
  availability_zone = "${var.zones[2]}"

  tags {
    Name = "Database Private Subnet-${var.zones[2]}"
  }
}

# Define the internet gateway
resource "aws_internet_gateway" "gw" {
  vpc_id = "${aws_vpc.default.id}"

  tags {
    Name = "VPC-IGW-URBN8"
  }
}

# Define the route table
resource "aws_route_table" "web-public-rt" {
  vpc_id = "${aws_vpc.default.id}"

  route {
    cidr_block = "0.0.0.0/0"
    gateway_id = "${aws_internet_gateway.gw.id}"
  }

  tags {
    Name = "Public-Subnet-RT"
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

# Define the security group for public subnet
resource "aws_security_group" "sgweb" {
  name = "vpc_test_web"
  description = "Allow incoming HTTP connections & SSH access"

  ingress {
    from_port = 80
    to_port = 80
    protocol = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }

  ingress {
    from_port = 443
    to_port = 443
    protocol = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }

  ingress {
    from_port = -1
    to_port = -1
    protocol = "icmp"
    cidr_blocks = ["0.0.0.0/0"]
  }

  ingress {
    from_port = 22
    to_port = 22
    protocol = "tcp"
    cidr_blocks =  ["112.197.14.10/32"]
  }

  vpc_id="${aws_vpc.default.id}"

  tags {
    Name = "Web Server SG"
  }
}

# Define the security group for private subnet
resource "aws_security_group" "sgdb"{
  name = "sg_test_web"
  description = "Allow traffic from public subnet"

  ingress {
    from_port = 3306
    to_port = 3306
    protocol = "tcp"
    cidr_blocks = ["${var.vpc_public_subnets}"]
  }

  ingress {
    from_port = -1
    to_port = -1
    protocol = "icmp"
    cidr_blocks = ["${var.vpc_public_subnets}"]
  }

  ingress {
    from_port = 22
    to_port = 22
    protocol = "tcp"
    cidr_blocks = ["${var.vpc_public_subnets}"]
  }

  vpc_id = "${aws_vpc.default.id}"

  tags {
    Name = "DB SG"
  }
}

resource "aws_db_subnet_group" "default" {
    name = "db-subnet-group"
    description = "RDS Subnet Group"
    subnet_ids = ["${aws_subnet.private-subnet-a.id}", "${aws_subnet.private-subnet-b.id}", "${aws_subnet.private-subnet-c.id}"]
    tags {
      Name = "DB Subnet Group"
    }
}
