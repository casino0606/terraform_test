provider "aws" {
  region = "us-east-1"
}


length(var.ipv4_cidrs) == 0 ?
cidrsubnet(
      signum(length(var.cidr_block)) == 1 ? var.cidr_block : var.cidr_block,
      ceil(log(local.public_count * 2, 2)),
      local.public_count + count.index
      )
  : var.ipv4_cidrs[count.index]