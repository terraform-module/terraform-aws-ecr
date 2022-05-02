output "ecr_repositores" {
  description = "Provides an Elastic Container Registry Repository."
  value       = module.ecrs.repositories
}

output "ecr_repository_url" {
  description = "The URL of the repository (in the form aws_account_id.dkr.ecr.region.amazonaws.com/repositoryName)"
  value       = module.ecrs.urls
}
