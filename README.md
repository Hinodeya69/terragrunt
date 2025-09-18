# Terragrunt GCP Platform

## Terragrunt Install

```bash
TERRAGRUNT_EXEC_NAME="terragrunt_linux_amd64"
curl -fsSL https://api.github.com/repos/gruntwork-io/terragrunt/releases/latest | \
grep "browser_download_url.*${TERRAGRUNT_EXEC_NAME}" | \
cut -d '"' -f 4 | \
wget -qi - && \
sudo mv ${TERRAGRUNT_EXEC_NAME} /usr/local/bin/terragrunt && \
sudo chmod +x /usr/local/bin/terragrunt
```

## Requirements 

- Create Cloud Identity or Google WorkSpace (Recommended Cloud Identity) - **If you have domain Name only**
> For Cloud Identity Or Google Workspace a domain name is required
> For Terraform export TF_VAR_organisation_id in your shell ~/.profile or ~/.bashrc and declare the variable with the same name in variable.tf "organisation_id" 
[Cloud_Identity](https://cloud.google.com/identity/docs/editions?visit_id=638938070673795129-2880435735&rd=1)
[Compare](https://support.google.com/a/answer/6043385)
- Create Bootstrap for first initialisation of Project/SA/WIF-POOL/Bucket
- Create GCP Project Dedicated Per LandingZone and LOB
- Create Billing Account
> For Terraform export TF_VAR_billing_account_id in your shell profile and declare the variable with the same name in variable.tf "billing_account_id"
[Sources](https://cloud.google.com/resource-manager/docs/creating-managing-organization)
- Check Billing Account
[Sources](https://console.cloud.google.com/billing)
- Set Authentification for Terraform
[Sources](https://cloud.google.com/docs/terraform/authentication?hl=fr)
[Sources](https://cloud.google.com/docs/authentication/provide-credentials-adc#how-to)
- Workload-Identity-Federation
[WIF](https://cloud.google.com/iam/docs/workload-identity-federation?hl=fr)
