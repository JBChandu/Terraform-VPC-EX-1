provider "aws" {
  region     = "us-east-1"
  access_key = var.AWS_CRED[0].access_key
  secret_key = var.AWS_CRED[0].secret_key
  token      = var.AWS_CRED[0].token
}

