# azurerm backend. Entra ID auth with OIDC, no access keys.
resource_group_name  = "joshwack-testing"
storage_account_name = "codepromotfu9bw"
container_name       = "tfstate"
key                  = "qa.tfstate"
use_oidc             = true
use_azuread_auth     = true
