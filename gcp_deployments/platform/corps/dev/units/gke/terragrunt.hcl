terraform {
  source = "../../../../../../modules/local/"  # Chemin vers votre module réutilisable
}

# inputs = {
#   project_name    = "corps-apps"
#   org_id          = dependency.root.inputs.organization_id  # Hérite des inputs racine root.hcl
#   billing_account = dependency.root.inputs.billing_account
# }
