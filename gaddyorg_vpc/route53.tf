
resource "aws_route53_zone" "gaddyorg" {
  name = "gaddy.org"
  vpc {
    vpc_id = aws_vpc.management.id
  }
}

resource "aws_route53_zone_association" "backend" {
  vpc_id = aws_vpc.backend.id
  zone_id = aws_route53_zone.gaddyorg.id
}

resource "aws_route53_zone_association" "frontend" {
  vpc_id = aws_vpc.frontend.id
  zone_id = aws_route53_zone.gaddyorg.id
}

resource "aws_route53_zone_association" "secrets" {
  vpc_id = aws_vpc.secrets.id
  zone_id = aws_route53_zone.gaddyorg.id
}

resource "aws_vpc_dhcp_options" "gaddyorg" {
  domain_name = "gaddy.org"
  domain_name_servers = local.dns_servers
  tags = {
    Managed_by = "Terraform"
  }
}

resource "aws_vpc_dhcp_options_association" "management" {
  dhcp_options_id = aws_vpc_dhcp_options.gaddyorg.id
  vpc_id = aws_vpc.management.id
}

resource "aws_vpc_dhcp_options_association" "backend" {
  dhcp_options_id = aws_vpc_dhcp_options.gaddyorg.id
  vpc_id = aws_vpc.backend.id
}

resource "aws_vpc_dhcp_options_association" "frontend" {
  dhcp_options_id = aws_vpc_dhcp_options.gaddyorg.id
  vpc_id = aws_vpc.frontend.id
}

resource "aws_vpc_dhcp_options_association" "secrets" {
  dhcp_options_id = aws_vpc_dhcp_options.gaddyorg.id
  vpc_id = aws_vpc.secrets.id
}