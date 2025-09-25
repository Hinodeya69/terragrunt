variable "billing_account_id" {
  type        = string
  description = "ID du compte de facturation GCP (fourni via variable d'environnement pour sécurité)"
  sensitive = true
  # Pas de default pour éviter d'exposer la valeur
}

variable "seed_project_name" {
  description = "The base name for the seed project"
  type        = string
  default     = "terraform-seed"
}


variable "project_suffix_length" {
  description = "Byte length for the random suffix in project ID"
  type        = number
  default     = 4
}


variable "enabled_apis" {
  description = "List of APIs to enable in the seed project"
  type        = set(string)
  default     = ["iam.googleapis.com", "cloudresourcemanager.googleapis.com", "serviceusage.googleapis.com", "iamcredentials.googleapis.com"]
}


variable "sa_account_id" {
  description = "Service account ID for the bootstrap account"
  type        = string
  default     = "terraform-bootstrap"
}


variable "sa_display_name" {
  description = "Display name for the bootstrap service account"
  type        = string
  default     = "Terraform Bootstrap SA"
}


variable "sa_roles" {
  description = "List of organization-level IAM roles to grant to the service account"
  type        = set(string)
  default     = ["roles/resourcemanager.projectCreator", "roles/billing.user", "roles/iam.serviceAccountAdmin"]
}


variable "state_bucket_prefix" {
  description = "Prefix for the Terraform state bucket name"
  type        = string
  default     = "terraform-state"
}


variable "state_bucket_location" {
  description = "Location for the Terraform state storage bucket"
  type        = string
  default     = "US"
}


variable "state_bucket_versioning_enabled" {
  description = "Enable versioning for the state bucket"
  type        = bool
  default     = true
}


variable "state_bucket_iam_role" {
  description = "IAM role to grant to the SA on the state bucket"
  type        = string
  default     = "roles/storage.objectAdmin"
}


variable "wif_pool_id" {
  description = "Workload Identity Federation pool ID"
  type        = string
  default     = "terraform-wif-pool"
}


variable "wif_pool_display_name" {
  description = "Display name for the Workload Identity Federation pool"
  type        = string
  default     = "Terraform WIF Pool"
}


variable "wif_provider_id" {
  description = "Workload Identity Federation provider ID (e.g., for GitHub)"
  type        = string
  default     = "github-provider"
}


variable "wif_provider_display_name" {
  description = "Display name for the Workload Identity Federation provider"
  type        = string
  default     = "GitHub WIF Provider"
}


variable "wif_oidc_issuer" {
  description = "OIDC issuer URI for Workload Identity Federation"
  type        = string
  default     = "https://token.actions.githubusercontent.com"
}


variable "wif_allowed_audiences" {
  description = "List of allowed audiences for OIDC tokens in WIF"
  type        = list(string)
  default     = ["https://example.com"]
}


variable "wif_attribute_mapping" {
  description = "Attribute mappings for Workload Identity Federation"
  type        = map(string)
  default     = {
    "google.subject"             = "assertion.sub"
    "attribute.repository"       = "assertion.repository"
    "attribute.repository_owner" = "assertion.repository_owner"
  }
}


variable "wif_impersonation_role" {
  description = "IAM role for WIF to impersonate the service account"
  type        = string
  default     = "roles/iam.workloadIdentityUser"
}


variable "wif_impersonation_member" {
  description = "Member expression for WIF impersonation (use placeholders like {pool_name})"
  type        = string
  default     = "principalSet://iam.googleapis.com/{pool_name}/*"
}
