# Command Sheet GCP

- Delete GCP Project
```bash
gcloud projects delete PROJECT_ID
```
- List Billing Account
> **There is no gcloud CLI command to create a billing account—this must be done manually in the Google Cloud Console by an authorized user**
```bash
gcloud beta billing accounts list

# Link Billing Account
gcloud billing projects link PROJECT_ID --billing-account=BILLING_ACCOUNT_ID
```
## Workload Identity Federation
```bash
# List all WIF pools (including deleted ones if needed):
gcloud iam workload-identity-pools list --location=global --show-deleted

gcloud iam workload-identity-pools describe POOL_ID --location=global

gcloud iam workload-identity-pools providers list --workload-identity-pool=POOL_ID --location=global
```