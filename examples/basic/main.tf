################################################################################
# Policies
################################################################################
locals {
  lifecycle_policy = {
    rules = [{
      rulePriority = 10
      description  = "keep last 20 images"
      action = {
        type = "expire"
      }
      selection = {
        tagStatus   = "any"
        countType   = "imageCountMoreThan"
        countNumber = 20
      }
    },
    {
      rulePriority = 1
      description  = "Expire untagged images older than 14 days"
      action = {
        type = "expire"
      }
      selection = {
        tagStatus   = "untagged"
        countType   = "sinceImagePushed"
        countUnit   = "days"
        countNumber = 1
      }
    }]
  }
}
################################################################################
# Resources
################################################################################
module "ecrs" {
  source = "../.."

  ecrs = {
    public-proxy-dev = {
      tags             = { Service = "public-proxy-dev", Env = "dev" }
      lifecycle_policy = local.lifecycle_policy
    },
    public-proxy-stage = {
      tags             = { Service = "public-proxy-stage", Env = "prod" }
      lifecycle_policy = local.lifecycle_policy
    },
    public-proxy-prod = {
      tags             = { Service = "public-proxy-prod", Env = "prod" }
      lifecycle_policy = local.lifecycle_policy
    }
  }
}
################################################################################
# OUTPUTS
################################################################################
output "ecr_registries" {
  value = flatten([
    module.ecrs.names
  ])
  description = "ECR repositories created."
}
