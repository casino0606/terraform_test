locals {
  #requirements
  gaddy_vpcs = ["Management", "Backend", "Frontend", "Secrets"]
  availalbe_cidrs = ["11.0.0.0/16", "12.0.0.0/16", "13.0.0.0/16", "14.0.0.0/16", "15.0.0.0/16","128.0.0.0/16" ]
  counter = length(local.gaddy_vpcs)
//  management_cidr = "11.0.0.0/16"
//  frontend_cidr = "12.0.0.0/16"
//  backend_cidr = "13.0.0.0/16"
//  secrets_cidr = "128.0.0.0/16"

  #subnet info
  management_sub = "11.0.1.0/24"
  frontend_cidr_pub = "12.0.1.0/24"
  frontend_cidr_priv = "12.0.2.0/24"
  backend_cidr_priv = "13.0.1.0/24"
  backend_cidr_nat = "13.0.2.0/24"
  secrets_cidr_priv = "128.0.1.0/24"

  dns_servers = ["11.0.0.2", "12.0.0.2", "13.0.0.2", "128.0.0.2"]
}

# Create Company VPC.

# Create Company VPC.

resource "aws_vpc" "gaddyorg-vpc" {
  count = local.counter
  cidr_block = "${element(local.availalbe_cidrs, count.index )}"
  enable_dns_hostnames = true
  tags = {
    Name = "${element(local.gaddy_vpcs, count.index )}"
  }
}

# Create Subnets

resource "aws_subnet" "management_pub" {
  count = local.counter
  cidr_block = cidrsubnets(element(local.gaddy_vpcs, count.index ), 8, 8)
  vpc_id = aws_vpc.gaddyorg-vpc[count.index].id
//  tags = {
//    Name = "Management_Public"
//    Class = "public"
//  }
}

//resource "aws_subnet" "frontend_pub" {
//  cidr_block = local.frontend_cidr_pub
//  vpc_id = aws_vpc.frontend.id
//  tags = {
//    Name = "Frontend_Public"
//    Class = "public"
//  }
//}
//
//resource "aws_subnet" "frontend_priv" {
//  cidr_block = local.frontend_cidr_priv
//  vpc_id = aws_vpc.frontend.id
//  tags = {
//    Name = "Frontend_Private"
//    Class = "private"
//  }
//}
//
//resource "aws_subnet" "backend_priv" {
//  cidr_block = local.backend_cidr_priv
//  vpc_id = aws_vpc.backend.id
//  tags = {
//    Name = "Backend_Private"
//    Class = "private"
//  }
//}
//
//resource "aws_subnet" "backend_nat" {
//  cidr_block = local.backend_cidr_nat
//  vpc_id = aws_vpc.backend.id
//  tags = {
//    Name = "Backend_NAT"
//    Class = "nat"
//  }
//}
//
//resource "aws_subnet" "secrets_priv" {
//  cidr_block = local.secrets_cidr_priv
//  vpc_id = aws_vpc.secrets.id
//  tags = {
//    Name = "Secrets_Private"
//    Class = "private"
//  }
//}

#Internet Gateway

resource "aws_internet_gateway" "management_gw" {
  vpc_id = data.aws_vpc.management.id
  tags = {
    Name = "Management_GW"
  }
}

resource "aws_internet_gateway" "frontend_gw" {
  vpc_id = data.aws_vpc.frontend.id
  tags = {
     Name = "Frontend_GW"
  }
}