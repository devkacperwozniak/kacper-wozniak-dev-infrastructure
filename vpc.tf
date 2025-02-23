resource "aws_vpc" "main" {
  cidr_block = "10.0.0.0/16"
  tags = {
    Name = "main-vpc"
  }
}

resource "aws_subnet" "public-1" {
  vpc_id                  = aws_vpc.main.id
  cidr_block              = "10.0.1.0/24"
  availability_zone       = "eu-west-3a"
  map_public_ip_on_launch = true
  tags = {
    Name = "public-subnet"
  }
}

resource "aws_subnet" "public-2" {
  vpc_id                  = aws_vpc.main.id
  cidr_block              = "10.0.2.0/24"
  availability_zone       = "eu-west-3b"
  map_public_ip_on_launch = true
  tags = {
    Name = "public-subnet"
  }
}

resource "aws_security_group" "aws_fargate_sg" {
  name        = "aws_fargate_sg"
  vpc_id      = aws_vpc.main.id

  tags = {
    Name = "aws_fargate_sg"
  }
}

resource "aws_vpc_security_group_ingress_rule" "aws_fargate_sg_ingress_http" {
  security_group_id = aws_security_group.aws_fargate_sg.id
  cidr_ipv4         = "0.0.0.0/0"
  from_port         = 80
  ip_protocol       = "-1"
  to_port           = 80
}

resource "aws_vpc_security_group_ingress_rule" "aws_fargate_sg_ingress_https" {
  security_group_id = aws_security_group.aws_fargate_sg.id
  cidr_ipv4         = "0.0.0.0/0"
  from_port         = 443
  ip_protocol       = "-1"
  to_port           = 443
}

resource "aws_vpc_security_group_egress_rule" "allow_all_traffic_ipv4" {
  security_group_id = aws_security_group.aws_fargate_sg.id
  cidr_ipv4         = "0.0.0.0/0"
  ip_protocol       = "-1"
}

resource "aws_vpc_security_group_egress_rule" "allow_all_traffic_ipv6" {
  security_group_id = aws_security_group.aws_fargate_sg.id
  cidr_ipv6         = "::/0"
  ip_protocol       = "-1"
}