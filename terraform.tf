terraform {
  required_version = "1.7.4"

  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = "5.38.0"
    }
  }

  backend "s3" {
    bucket         = "prepare-bucketterraformstates-cxxp0e0isfpp"
    key            = "cloud/tfstate.json"
    region         = "ap-northeast-1"
    dynamodb_table = "prepare-TableTerraformLocks-5OEJP1YJFV3Z"
  }
}

provider "aws" {
  region = local.region

  default_tags {
    tags = {
      SystemName = local.system_name
      Repository = "cloud"
    }
  }
}

locals {
  region      = "ap-northeast-1"
  system_name = "luciferous-mail-processor-cloud"
}

module "common" {
  source = "terraform_modules/common"

  receive_domain = var.RECEIVE_DOMAIN
}

variable "RECEIVE_DOMAIN" {
  type     = string
  nullable = false
}
