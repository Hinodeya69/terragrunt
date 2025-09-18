# provider "google" {
#   # Initial auth: Use your user credentials or set GOOGLE_CREDENTIALS env var
#   # Use gcloud auth application-default login
# }


# Random suffix to ensure unique project ID
resource "random_id" "project_suffix" {
  byte_length = var.project_suffix_length
}


# Create seed project
resource "google_project" "seed" {
  name             = var.seed_project_name
  project_id       = "${var.seed_project_name}-${random_id.project_suffix.hex}"
  billing_account  = var.billing_account_id  # Valeur fournie via variable d'environnement TF_VAR_billing_account_id pour sécurité
}


# Enable necessary APIs in seed project
resource "google_project_service" "apis" {
  for_each = var.enabled_apis
  project  = google_project.seed.project_id
  service  = each.value
}


# Create service account for Terraform/Terragrunt
resource "google_service_account" "terraform_sa" {
  account_id   = var.sa_account_id
  display_name = var.sa_display_name
  project      = google_project.seed.project_id
}
# Create GCS bucket for Terraform state
resource "google_storage_bucket" "state_bucket" {
  name     = "${var.state_bucket_prefix}-${google_project.seed.project_id}"
  location = var.state_bucket_location
  project  = google_project.seed.project_id
  versioning {
    enabled = var.state_bucket_versioning_enabled
  }
  depends_on = [google_project.seed]  # Assure que le projet est créé d'abord
}

# Grant SA access to state bucket
resource "google_storage_bucket_iam_member" "state_access" {
  bucket = google_storage_bucket.state_bucket.name
  role   = var.state_bucket_iam_role
  member = "serviceAccount:${google_service_account.terraform_sa.email}"
}

# Set up Workload Identity Federation (e.g., for GitHub Actions)
resource "google_iam_workload_identity_pool" "wif_pool" {
  workload_identity_pool_id = var.wif_pool_id
  display_name              = var.wif_pool_display_name
  project                   = google_project.seed.project_id
  depends_on                = [google_project.seed]  # Assure que le projet est créé d'abord
}

resource "google_iam_workload_identity_pool_provider" "wif_provider" {
  workload_identity_pool_id          = google_iam_workload_identity_pool.wif_pool.workload_identity_pool_id
  workload_identity_pool_provider_id = var.wif_provider_id
  display_name                       = var.wif_provider_display_name
  project                            = google_project.seed.project_id
  oidc {
    issuer_uri        = var.wif_oidc_issuer
    allowed_audiences = var.wif_allowed_audiences
  }
  attribute_mapping = var.wif_attribute_mapping
  attribute_condition = "assertion.repository == attribute.repository && assertion.repository_owner == attribute.repository_owner"  # Condition pour valider les claims et corriger l'erreur
  depends_on        = [google_iam_workload_identity_pool.wif_pool]  # Dépend du pool WIF
}

# Allow WIF to impersonate the SA
resource "google_service_account_iam_member" "wif_impersonation" {
  service_account_id = google_service_account.terraform_sa.name
  role               = var.wif_impersonation_role
  member             = replace(var.wif_impersonation_member, "{pool_name}", google_iam_workload_identity_pool.wif_pool.name)
}
