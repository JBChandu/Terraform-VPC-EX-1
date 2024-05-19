# Generate an Ed25519 key pair
resource "tls_private_key" "example" {
  algorithm = "ED25519"
}

# Save the private key locally
resource "local_file" "private_key" {
  content         = tls_private_key.example.private_key_openssh
  filename        = "${path.module}/deployer-key.pem"
  file_permission = "0600"
}

# Create an AWS key pair using the generated public key
resource "aws_key_pair" "deployer" {
  key_name   = "deployer-key"
  public_key = tls_private_key.example.public_key_openssh
}