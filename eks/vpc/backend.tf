terraform {
  backend "s3" {
    bucket  = "bootcamp32-dev-13"
    region  = "us-east-1"
    key     = "oidc/terraform.tfstate"
    encrypt = true
  }
}