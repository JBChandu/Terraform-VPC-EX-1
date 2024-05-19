#Commented all code because they are split into seperate files 
#Create a new VPC

# resource "aws_vpc" "VPC_A" {
#   cidr_block = "10.100.0.0/16"

#   tags = {
#     Name = "VPC-A"
#   }
# }

#Create an Internet Gateway & associate with your VPC
# resource "aws_internet_gateway" "igw" {
#   vpc_id = aws_vpc.VPC_A.id
#   tags = {
#     Name = "VPC-A_IGW"
#   }
# }

#Create a Subnet in one of theavailability zones. Enable Auto-assign Public IP for a subnet.
# resource "aws_subnet" "VPC-A_Public-1" {
#   vpc_id                  = aws_vpc.VPC_A.id
#   cidr_block              = "10.100.0.0/24"
#   availability_zone       = "us-east-1a"
#   map_public_ip_on_launch = true

#   tags = {
#     Name = "VPC-A_Public-1"
#   }
# }


#Create a Route table and add a route for destination (0.0.0.0/0) with target as an Internet Gateway

# resource "aws_route_table" "VPC-A_Public_RT" {
#   vpc_id = aws_vpc.VPC_A.id

#   #   route {
#   #     cidr_block = "10.100.0.0/16"
#   #     gateway_id = "local"
#   #   }

#   route {
#     cidr_block = "0.0.0.0/0"
#     gateway_id      = aws_internet_gateway.igw.id
#   }

#   tags = {
#     Name = "VPC-A_Public_RT"
#   }
# }
# Associate route table with your subnet
# resource "aws_route_table_association" "a" {
#   subnet_id      = aws_subnet.VPC-A_Public-1.id
#   route_table_id = aws_route_table.VPC-A_Public_RT.id
# }

# Launch EC2 instance in your subnet.
#create security groups and assign to EC2-instance
# resource "aws_security_group" "secGrp1" {
#   name        = "securityGroup-1"
#   description = "Allow ssh connection"
#   vpc_id      = aws_vpc.VPC_A.id

#   ingress {
#     description      = "ssh"
#     from_port        = 22
#     to_port          = 22
#     protocol         = "tcp"
#     cidr_blocks      = ["0.0.0.0/0"]
#     ipv6_cidr_blocks = ["::/0"]
#   }

#   ingress {
#     description      = "HTTPS"
#     from_port        = 443
#     to_port          = 443
#     protocol         = "tcp"
#     cidr_blocks      = ["0.0.0.0/0"]
#     ipv6_cidr_blocks = ["::/0"]
#   }
#   ingress {
#     description      = "HTTP"
#     from_port        = 80
#     to_port          = 80
#     protocol         = "tcp"
#     cidr_blocks      = ["0.0.0.0/0"]
#     ipv6_cidr_blocks = ["::/0"]
#   }

#    egress {
#     from_port   = 0
#     to_port     = 0
#     protocol    = "-1"
#     cidr_blocks = ["0.0.0.0/0"]
#   }

#   tags = {
#     Name = "SecGrp-1"
#   }
# }

#create EC2 instance under vpc->publicsubnet and assign security group
# resource "aws_instance" "MyEC2" {
#   ami             = "ami-0bb84b8ffd87024d8" # Change to your preferred AMI ID
#   instance_type   = "t2.micro"
#   subnet_id       = aws_subnet.VPC-A_Public-1.id
#   security_groups = ["${aws_security_group.secGrp1.id}"]
#   key_name        = aws_key_pair.deployer.key_name
# user_data = <<-EOF
#             #!/bin/bash
#             yum update -y
#             yum install httpd -y
#             systemctl start httpd
#             systemctl enable httpd
#             cd /var/www/html
#             echo "<h1>Welcome to My WebServer</h1>" > index.html
#             EOF

#   tags = {
#     Name = "MyEC2-instance"
#   }
# }

# Output the instance ID and public IP
# output "instance_id" {
#   value = aws_instance.MyEC2.id
# }

# output "instance_public_ip" {
#   value = aws_instance.MyEC2.public_ip
# }

# output "webserver_page" {
#   value = "${aws_instance.MyEC2.public_ip}:80"
# }

# Connect to EC2 instance over SSH using its Public IP


# # Generate an Ed25519 key pair
# resource "tls_private_key" "example" {
#   algorithm = "ED25519"
# }

# # Save the private key locally
# resource "local_file" "private_key" {
#   content         = tls_private_key.example.private_key_openssh
#   filename        = "${path.module}/deployer-key.pem"
#   file_permission = "0600"
# }

# # Create an AWS key pair using the generated public key
# resource "aws_key_pair" "deployer" {
#   key_name   = "deployer-key"
#   public_key = tls_private_key.example.public_key_openssh
# }

# Output the private key file location
# output "private_key_path" {
#   value     = local_file.private_key.filename
#   sensitive = true
# }