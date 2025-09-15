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
