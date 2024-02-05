terraform {
  required_version = ">= 1.0"
  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = "5.26.0"
    }

    random = {
      source  = "hashicorp/random"
      version = "3.5.1"
    }
  }
}

provider "aws" {
  region = "ap-northeast-2"
}

resource "random_string" "random" {
  length  = 8
  special = false
  upper   = false
}

