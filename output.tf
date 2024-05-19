# Output the EC2 instance ID and public IP
output "instance_id" {
  value = aws_instance.MyEC2.id
}

output "instance_public_ip" {
  value = aws_instance.MyEC2.public_ip
}

# Output the private key file location
output "private_key_path" {
  value     = local_file.private_key.filename
  sensitive = true
}

#output url of webpage serverd by webserver
output "webserver_page" {
  value = "${aws_instance.MyEC2.public_ip}:80"
}