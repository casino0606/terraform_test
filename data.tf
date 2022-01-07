data "aws_vpc" "management" {
  tags = {
    Name = "Management"
  }
}

data "aws_vpc" "frontend" {
  tags = {
    Name = "Frontend"
  }
}