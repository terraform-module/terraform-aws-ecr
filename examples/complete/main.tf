locals {
  region = "eu-west-1"

  tags = {
    Stack      = "ecr"
    GithubRepo = "terraform-aws-ecrs"
    GithubOrg  = "terraform-module"
  }
}

provider "aws" {
  region = local.region

  default_tags {
    tags = {
      ExampleDefaultTag = "ExampleDefaultValue"
    }
  }
}
