# projects/project1/terragrunt.hcl

include "root" {
  path = find_in_parent_folders("root.hcl")  # Hérite de root.hcl à la racine
}

terraform {
  source = "../../modules/project"  # Chemin vers votre module réutilisable
}

# inputs = {
#   project_name    = "corps-apps"
#   org_id          = dependency.root.inputs.organization_id  # Hérite des inputs racine root.hcl
#   billing_account = dependency.root.inputs.billing_account
# }
