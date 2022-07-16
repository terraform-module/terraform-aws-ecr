output "repositories" {
  description = "Provides an Elastic Container Registry Repositories."
  value       = try(flatten(aws_ecr_repository.this[*]), [])
}

output "urls" {
  description = "The URL of the repository (in the form aws_account_id.dkr.ecr.region.amazonaws.com/repositoryName)."
  value       = { for k, v in aws_ecr_repository.this : k => v.repository_url }
}

output "names" {
  description = "The Names of the repository (in the form repositoryname)."
  value       = [ for v in aws_ecr_repository.this : v.name ]
}
