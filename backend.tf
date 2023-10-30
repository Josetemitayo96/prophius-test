terraform {
  backend "s3" {
    bucket = "test-terraform-m"
    region = "eu-west-1"
    key    = "terraform.tfstate"
    shared_credentials_file = "/Users/temitayojose/.aws/credentials"
    profile                 = ""
  }
}