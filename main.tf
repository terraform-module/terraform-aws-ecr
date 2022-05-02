locals {
  defaults = {
    scan_on_push         = true
    image_tag_mutability = "MUTABLE"
  }
}

resource "aws_ecr_repository" "this" {

  for_each = { for k, v in var.ecrs : k => v }

  name                 = each.key
  image_tag_mutability = try(each.value.image_tag_mutability, local.defaults.image_tag_mutability)

  image_scanning_configuration {
    scan_on_push = try(each.value.scan_on_push, local.defaults.scan_on_push)
  }

  encryption_configuration {
    encryption_type = "AES256"
  }

  tags = merge(var.tags, try(each.value.tags, null))
}
