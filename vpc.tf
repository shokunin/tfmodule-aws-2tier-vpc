resource "aws_vpc" "vpc" {
  cidr_block           = var.vpc-cidr
  enable_dns_hostnames = var.enable-vpc-dns
  enable_dns_support   = var.enable-vpc-dns
  tags                 = merge({ Name = "${var.vpc-name}-VPC" }, var.common-tags)
}

resource "aws_internet_gateway" "vpc" {
  vpc_id = aws_vpc.vpc.id
  tags   = merge({ Name = "${var.vpc-name}-IGW" }, var.common-tags)
}

