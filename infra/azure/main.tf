# Deploy target: an Azure Storage static website, one storage account per
# environment. Terraform manages only the website setting and index.html. The
# storage account itself is pre-created (SETUP.md, Azure section), so the plan
# identity never needs write access at resource-group level.

# The subscription comes from the OIDC login (ARM_SUBSCRIPTION_ID), so it isn't
# committed to this public repo.
data "azurerm_client_config" "current" {}

locals {
  site_storage_account_id = "/subscriptions/${data.azurerm_client_config.current.subscription_id}/resourceGroups/${var.site_resource_group}/providers/Microsoft.Storage/storageAccounts/${var.site_storage_account_name}"
}

resource "azurerm_storage_account_static_website" "site" {
  storage_account_id = local.site_storage_account_id
  index_document     = "index.html"
}

resource "azurerm_storage_blob" "index" {
  name                 = "index.html"
  storage_container_id = "${local.site_storage_account_id}/blobServices/default/containers/$web"
  type                 = "Block"
  content_type         = "text/html; charset=utf-8"
  cache_control        = "no-cache"

  source_content = replace(
    replace(
      replace(file("${path.module}/../../app/index.html"), "__COMMIT__", var.commit),
      "__VERSION__", var.app_version
    ),
    "__ENVIRONMENT__", var.environment
  )

  # The $web container exists only once the static website is enabled.
  depends_on = [azurerm_storage_account_static_website.site]
}
