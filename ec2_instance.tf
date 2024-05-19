resource "aws_instance" "MyEC2" {
  ami             = "ami-0bb84b8ffd87024d8" # Change to your preferred AMI ID
  instance_type   = "t2.micro"
  subnet_id       = aws_subnet.VPC-A_Public-1.id
  security_groups = ["${aws_security_group.secGrp1.id}"]
  key_name        = aws_key_pair.deployer.key_name
  user_data       = <<-EOF
            #!/bin/bash
            yum update -y
            yum install httpd -y
            systemctl start httpd
            systemctl enable httpd
            cd /var/www/html
            echo "<h1>Welcome to My WebServer</h1>" > index.html
            EOF

  tags = {
    Name = "MyEC2-instance"
  }
}