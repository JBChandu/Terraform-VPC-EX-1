resource "aws_vpc" "VPC_A" {
  cidr_block = "10.100.0.0/16"

  tags = {
    Name = "VPC-A"
  }
}