# azurerm backend. Entra ID auth with OIDC, no access keys.
resource_group_name  = "metlife-demo-codepromo"
storage_account_name = "REPLACE_TFSTATE_ACCOUNT"
container_name       = "tfstate"
key                  = "qa.tfstate"
use_oidc             = true
use_azuread_auth     = true
