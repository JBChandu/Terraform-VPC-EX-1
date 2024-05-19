resource "aws_internet_gateway" "igw" {
  vpc_id = aws_vpc.VPC_A.id
  tags = {
    Name = "VPC-A_IGW"
  }
}