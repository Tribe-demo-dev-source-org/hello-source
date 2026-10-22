terraform {
  required_version = ">= 1.9.0"

  required_providers {
    azurerm = {
      source  = "hashicorp/azurerm"
      version = "~> 4.81"
    }
  }

  # Partial configuration. The workflow passes -backend-config=backend/<env>.hcl.
  backend "azurerm" {}
}

provider "azurerm" {
  features {}

  # OIDC from the GitHub Environment: ARM_USE_OIDC, ARM_CLIENT_ID, ARM_TENANT_ID and
  # ARM_SUBSCRIPTION_ID are set by the workflow. No secret is stored.
  use_oidc = true

  # Use Entra ID for blob data-plane calls, not account keys, so no identity needs
  # listKeys. The read-only prod-plan identity can then plan.
  storage_use_azuread = true

  # The identities hold only resource-group-scoped roles, so the provider must not
  # register resource providers.
  resource_provider_registrations = "none"
}
