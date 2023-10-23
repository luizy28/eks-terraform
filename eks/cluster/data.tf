data "terraform_remote_state" "network" {
  backend = "s3"
  config = {
    bucket = "bootcamp32-dev-13"
    key    = "oidc/terraform.tfstate"
    region = "us-east-1"
  }
}