output "service_account_email" {
  description = "Email du service account bootstrap Terraform"
  value       = google_service_account.terraform_sa.email
}

output "seed_project_id" {
  description = "ID du projet seed créé par le bootstrap"
  value       = google_project.seed.project_id
}

output "state_bucket_name" {
  description = "Nom du bucket GCS utilisé pour l'état distant Terraform"
  value       = google_storage_bucket.state_bucket.name
}

output "wif_pool_name" {
  description = "Nom du pool Workload Identity Federation"
  value       = google_iam_workload_identity_pool.wif_pool.name
}

output "wif_provider_name" {
  description = "Nom du provider Workload Identity Federation"
  value       = google_iam_workload_identity_pool_provider.wif_provider.name
}
