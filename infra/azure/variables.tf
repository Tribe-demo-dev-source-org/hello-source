variable "environment" {
  description = "qa or prod. Shown on the page."
  type        = string

  validation {
    condition     = contains(["qa", "prod"], var.environment)
    error_message = "environment must be qa or prod."
  }
}

variable "commit" {
  description = "Full commit SHA being deployed. Shown on the page."
  type        = string
}

variable "app_version" {
  description = "Release tag (prod) or main@<sha7> (qa). Shown on the page."
  type        = string
}

variable "site_resource_group" {
  description = "Resource group of the site storage accounts."
  type        = string
  default     = "metlife-demo-codepromo"
}

variable "site_storage_account_name" {
  description = "This environment's site storage account. The azure agent pre-creates it (SETUP.md, Azure section)."
  type        = string
}

variable "site_url" {
  description = "Primary static-website endpoint of the site storage account, e.g. https://<name>.z20.web.core.windows.net/"
  type        = string
}
