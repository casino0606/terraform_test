locals {
  #requirements
  gaddy_vpcs      = ["Management", "Backend", "Frontend", "Secrets"]
  available_cidrs = ["11.0.0.0/16", "12.0.0.0/16", "13.0.0.0/16", "14.0.0.0/16", "15.0.0.0/16", "128.0.0.0/16"]
  counter         = length(local.gaddy_vpcs)

  #subnet info
  management_sub     = "11.0.1.0/24"
  frontend_cidr_pub  = "12.0.1.0/24"
  frontend_cidr_priv = "12.0.2.0/24"
  backend_cidr_priv  = "13.0.1.0/24"
  backend_cidr_nat   = "13.0.2.0/24"
  secrets_cidr_priv  = "128.0.1.0/24"

  dns_servers = ["11.0.0.2", "12.0.0.2", "13.0.0.2", "128.0.0.2"]
}

# Create Company VPC.

resource "aws_vpc" "gaddyorg-vpc" {
  count                = local.counter
  cidr_block           = element(local.available_cidrs, count.index)
  enable_dns_hostnames = true
  tags = {
    Name = element(local.gaddy_vpcs, count.index)
  }
}

# Create Subnets

//resource "aws_subnet" "management_pub" {
//  count = local.counter
//  cidr_block = cidrsubnets(element(local.gaddy_vpcs, count.index ), 8, 8)
//  vpc_id = aws_vpc.gaddyorg-vpc[count.index].id
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
# This is a test message.