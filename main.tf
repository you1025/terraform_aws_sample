# configurations
terraform {
  required_version = ">=1.5"
  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = "~>3.0"
    }
  }
}

# provider
provider "aws" {
  profile = "terraform"
  region  = var.region
}

# variables
variable "project" {
  type = string
}
variable "region" {
  type = string
}
variable "environment" {
  type = string
}