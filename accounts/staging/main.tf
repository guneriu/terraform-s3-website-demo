terraform {
  backend "local" {
    path = "../../backend/terraform.staging.tfstate"
  }

// uncomment to use s3 backend
//  backend "s3" {
//    bucket         = "terraform-backend-s3-deployer"
//    region         = "eu-central-1"
//    key            = "infrastructure/terraform-s3-deployer-${local.stage}.tfstate"
//    dynamodb_table = "terraform-s3-deployer-${local.stage}-state-lock-dynamo"
//  }
}

locals {
  stage = "staging"
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
  stage = local.stage
  zone  = "acme.com"
}
