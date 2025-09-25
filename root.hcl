# # Configuration de l'état distant (remote state) - Use static values from bootstrap outputs
# remote_state {
#   backend = "gcs"
#   config = {
#     bucket = "actual-state-bucket-name-from-bootstrap"  # Replace with real value from bootstrap output "state_bucket_name"
#     prefix = "${path_relative_to_include()}/terraform.tfstate"  # Dynamic prefix for submodules
#   }
# }

# # # Génération automatique du bloc provider - Use static values from bootstrap outputs
# # generate "provider" {
# #   path      = "provider.tf"
# #   if_exists = "overwrite_terraform"
# #   contents  = <<EOF
# # provider "google" {
# #   project = "terraform-seed"  # Replace with real value from bootstrap output "seed_project_id"

# #   # Configuration WIF pour authentification fédérée
# #   workload_identity_pool     = "projects/terraform-seed/locations/global/workloadIdentityPools/terraform-wif-pool"  # Replace with "wif_pool_name"
# #   workload_identity_provider = "projects/actual-seed-project-id-from-bootstrap/locations/global/workloadIdentityPools/actual-wif-pool-from-bootstrap/providers/github-provider"  # Replace with "wif_provider_name"
# # }
# # EOF
# # }
# generate "backend" {
#   path      = "backend.tf"
#   if_exists = "overwrite"  # Changez de "overwrite_terragrunt" à "overwrite" si besoin, ou testez "skip"
#   contents  = <<EOF
# terraform {
#   backend "gcs" {}
# }
# EOF
# }

# # # Global inputs (static or passed via CLI/env)
# # inputs = {
# #   organization_id   = "votre-org-id"
# #   billing_account   = "votre-billing-id"
# # }
