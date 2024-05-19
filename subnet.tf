resource "aws_subnet" "VPC-A_Public-1" {
  vpc_id                  = aws_vpc.VPC_A.id
  cidr_block              = "10.100.0.0/24"
  availability_zone       = "us-east-1a"
  map_public_ip_on_launch = true

  tags = {
    Name = "VPC-A_Public-1"
  }
}

# Associate route table with your subnet
resource "aws_route_table_association" "a" {
  subnet_id      = aws_subnet.VPC-A_Public-1.id
  route_table_id = aws_route_table.VPC-A_Public_RT.id
}