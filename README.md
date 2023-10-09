# AWS ECR(s) Terraform module

Terraform module which creates AWS ECR resources in bulk.

> Amazon Elastic Container Registry. Share and deploy container software, publicly or privately

---

![](https://github.com/terraform-aws-modules/terraform-aws-ecr/workflows/release/badge.svg)
![](https://github.com/terraform-aws-modules/terraform-aws-ecr/workflows/commit-check/badge.svg)
![](https://github.com/terraform-aws-modules/terraform-aws-ecr/workflows/labeler/badge.svg)

[![](https://img.shields.io/github/license/terraform-aws-modules/terraform-aws-ecr)](https://github.com/terraform-aws-modules/terraform-aws-ecr)
![](https://img.shields.io/github/v/tag/terraform-aws-modules/terraform-aws-ecr)
![](https://img.shields.io/issues/github/terraform-aws-modules/terraform-aws-ecr)
![](https://img.shields.io/github/issues/terraform-aws-modules/terraform-aws-ecr)
![](https://img.shields.io/github/issues-closed/terraform-aws-modules/terraform-aws-ecr)
[![](https://img.shields.io/github/languages/code-size/terraform-aws-modules/terraform-aws-ecr)](https://github.com/terraform-aws-modules/terraform-aws-ecr)
[![](https://img.shields.io/github/repo-size/terraform-aws-modules/terraform-aws-ecr)](https://github.com/terraform-aws-modules/terraform-aws-ecr)
![](https://img.shields.io/github/languages/top/terraform-aws-modules/terraform-aws-ecr?color=green&logo=terraform&logoColor=blue)
![](https://img.shields.io/github/commit-activity/m/terraform-aws-modules/terraform-aws-ecr)
![](https://img.shields.io/github/contributors/terraform-aws-modules/terraform-aws-ecr)
![](https://img.shields.io/github/last-commit/terraform-aws-modules/terraform-aws-ecr)
[![Maintenance](https://img.shields.io/badge/Maintenu%3F-oui-green.svg)](https://GitHub.com/terraform-aws-modules/terraform-aws-ecr/graphs/commit-activity)
[![GitHub forks](https://img.shields.io/github/forks/terraform-aws-modules/terraform-aws-ecr.svg?style=social&label=Fork)](https://github.com/terraform-aws-modules/terraform-aws-ecr)

---

## Documentation

- [TFLint Rules](https://github.com/terraform-linters/tflint/tree/master/docs/rules)

## Usage example

IMPORTANT: The master branch is used in source just as an example. In your code, do not pin to master because there may be breaking changes between releases. Instead pin to the release tag (e.g. ?ref=tags/x.y.z) of one of our [latest releases](https://github.com/terraform-aws-modules/terraform-aws-ecr/releases).

See `examples` directory for working examples to reference:

```hcl
module "blueprint" {
  source  = "terraform-module/ecr/aws"
  version = "~> 1.0"

  ecrs = {
    api = {
      tags = { Service = "api" }
      lifecycle_policy = {
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
      }
      permissions = [
        {
          Sid = "AllowAllActionsOnECR"
          Effect = "Allow"
          Principal = {
            AWS = "arn:aws:iam::111111111111:root"
          }
          Action = ["ecr:*"]
        }
      ]
    }
  }
}
```

Push docker image to repository

```sh
export ECR_REPO=AWS_ACCOUNT_ID.dkr.ecr.<REGION>.amazonaws.com/repositoryName
aws ecr get-login-password --region <REGION> | docker login --username AWS --password-stdin $ECR_REPO
docker pull cloudkats/hello-world-rest:latest
docker tag cloudkats/hello-world-rest:latest $ECR_REPO/api:latest
docker push $ECR_REPO/api:latest
```

## Examples

See `examples` directory for working examples to reference

- [Examples Dir](https://github.com/terraform-module/module-blueprint/tree/master/examples/)

## Assumptions

## Available features

- Create multiple ECR repositories
- Manages an ECR repository lifecycle policy.

<!-- BEGINNING OF PRE-COMMIT-TERRAFORM DOCS HOOK -->
## Requirements

| Name | Version |
|------|---------|
| <a name="requirement_terraform"></a> [terraform](#requirement\_terraform) | >= 1 |
| <a name="requirement_aws"></a> [aws](#requirement\_aws) | >= 4.0, < 6.0 |

## Providers

| Name | Version |
|------|---------|
| <a name="provider_aws"></a> [aws](#provider\_aws) | >= 4.0, < 6.0 |

## Modules

No modules.

## Resources

| Name | Type |
|------|------|
| [aws_ecr_lifecycle_policy.this](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/ecr_lifecycle_policy) | resource |
| [aws_ecr_repository.this](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/ecr_repository) | resource |
| [aws_ecr_repository_policy.this](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/ecr_repository_policy) | resource |

## Inputs

| Name | Description | Type | Default | Required |
|------|-------------|------|---------|:--------:|
| <a name="input_ecrs"></a> [ecrs](#input\_ecrs) | Map of ECRs to create. | `any` | `{}` | no |
| <a name="input_tags"></a> [tags](#input\_tags) | A mapping of tags to assign to all resources | `map(string)` | `{}` | no |

## Outputs

| Name | Description |
|------|-------------|
| <a name="output_names"></a> [names](#output\_names) | The Names of the repository (in the form repositoryname). |
| <a name="output_repositories"></a> [repositories](#output\_repositories) | Provides an Elastic Container Registry Repositories. |
| <a name="output_urls"></a> [urls](#output\_urls) | The URL of the repository (in the form aws\_account\_id.dkr.ecr.region.amazonaws.com/repositoryName). |
<!-- END OF PRE-COMMIT-TERRAFORM DOCS HOOK -->


### :memo: Guidelines

 - :memo: Use a succinct title and description.
 - :bug: Bugs & feature requests can be be opened
 - :signal_strength: Support questions are better asked on [Stack Overflow](https://stackoverflow.com/)
 - :blush: Be nice, civil and polite ([as always](http://contributor-covenant.org/version/1/4/)).

## License

Copyright 2019 Ivan Katliarhcuk

MIT Licensed. See [LICENSE](./LICENSE) for full details.

## How to Contribute

Submit a pull request

# Authors

Currently maintained by [Ivan Katliarchuk](https://github.com/ivankatliarchuk) and these [awesome contributors](https://github.com/terraform-aws-modules/terraform-aws-ecr/graphs/contributors).

[![ForTheBadge uses-git](http://ForTheBadge.com/images/badges/uses-git.svg)](https://GitHub.com/)

## Terraform Registry

- [Module](https://registry.terraform.io/modules/terraform-module/ecrs/aws)

## Resources

- [Terraform modules](https://registry.terraform.io/namespaces/terraform-module)
