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

module "ecrs" {
  source  = "terraform-module/ecrs/aws"
  version = "~> 1.0"

  ecrs = {
    api = {
      tags = { Service = "api" }
      lifecycle_policy = jsonencode({
        rules = [{
          rulePriority = 1
          description  = "keep last 50 images"
          action = {
            type = "expire"
          }
          selection = {
            tagStatus   = "any"
            countType   = "imageCountMoreThan"
            countNumber = 50
          }
        }]
      })
    }
    web = {
      image_tag_mutability = "IMMUTABLE"
      tags                 = { Service = "web" }
      lifecycle_policy = jsonencode({
        rules = [{
          rulePriority = 1
          description  = "Expire images older than 14 days"
          action = {
            type = "expire"
          }
          selection = {
            tagStatus : "untagged",
            countType : "sinceImagePushed",
            countUnit : "days",
            countNumber : 14
          }
        }]
      })
    }
  }
  tags = local.tags
}

