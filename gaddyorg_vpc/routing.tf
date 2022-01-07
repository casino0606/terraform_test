resource "aws_route_table" "management" {
  vpc_id = aws_vpc.management.id
  route {
    cidr_block = "0.0.0.0/0"
    gateway_id = aws_internet_gateway.management_gw.id
  }
  route {
    ipv6_cidr_block = "::/0"
    gateway_id = aws_internet_gateway.management_gw.id
  }
}

resource "aws_route_table" "frontend" {
  vpc_id = aws_vpc.frontend.id
  route {
    cidr_block = "0.0.0.0/0"
    gateway_id = aws_internet_gateway.frontend_gw.id
  }
  route {
    ipv6_cidr_block = "::/0"
    gateway_id = aws_internet_gateway.frontend_gw.id
  }
}

resource "aws_route_table_association" "management" {
  route_table_id = aws_route_table.management.id
  subnet_id = aws_subnet.management_pub.id
}

resource "aws_route_table_association" "frontend" {
  route_table_id = aws_route_table.frontend.id
  subnet_id = aws_subnet.frontend_pub.id
}