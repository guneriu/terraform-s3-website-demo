terraform {
  backend "local" {
    path = "../../backend/terraform.dev.tfstate"
  }
}

provider "aws" {
  region  = "eu-central-1"
  version = "3.28"
}

provider "aws" {
  region  = "us-east-1"
  alias   = "us-east-1"
  version = "3.28"
}

module "s3-deployer" {
  source = "../../modules/s3-deployer"
  stage  = "dev"
  zone   = "acme.com"
}
