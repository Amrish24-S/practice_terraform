resource "aws_vpc" "ter-vpc" {
  cidr_block           = "15.0.0.0/16"
  instance_tenancy     = "default"
  enable_dns_hostnames = "true"
  enable_dns_support   = "true"
  tags = {
    Name = "ter-vpc"
  }
}
resource "aws_subnet" "ter-pub-sub" {
  vpc_id                  = aws_vpc.ter-vpc.id
  cidr_block              = "15.0.1.0/24"
  map_public_ip_on_launch = "true"
  availability_zone       = var.ZONE
  tags = {
    Name = "ter-pub-sub"
  }
}
resource "aws_internet_gateway" "ter-ig" {
  vpc_id = aws_vpc.ter-vpc.id
  tags = {
    Name = "ter-ig"
  }
}
resource "aws_route_table" "aws_rt" {
  vpc_id = aws_vpc.ter-vpc.id
  route {
    cidr_block = "0.0.0.0/0"
    gateway_id = aws_internet_gateway.ter-ig.id
  }
  tags = {
    Name = "aws_rt"
  }
}
resource "aws_route_table_association" "ter-rt-asso" {
  subnet_id      = aws_subnet.ter-pub-sub.id
  route_table_id = aws_route_table.aws_rt.id
}