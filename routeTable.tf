resource "aws_route_table" "VPC-A_Public_RT" {
  vpc_id = aws_vpc.VPC_A.id

  #   route {
  #     cidr_block = "10.100.0.0/16"
  #     gateway_id = "local"
  #   }

  route {
    cidr_block = "0.0.0.0/0"
    gateway_id = aws_internet_gateway.igw.id
  }

  tags = {
    Name = "VPC-A_Public_RT"
  }
}