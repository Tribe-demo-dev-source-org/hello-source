# NO-CLOUD mode (DEPLOY_MODE=local). Use it if Azure isn't approved.
# Renders the page with the version and commit substituted, then writes it to
# site/index.html. The deploy workflow uploads that file as a run artifact. Plan,
# saved-plan apply and the approvals behave exactly as in Azure mode. Only the
# target differs.

terraform {
  required_version = ">= 1.9.0"

  required_providers {
    local = {
      source  = "hashicorp/local"
      version = "~> 2.5"
    }
  }
}

variable "environment" {
  type = string
}

variable "commit" {
  type = string
}

variable "app_version" {
  type = string
}

resource "local_file" "index" {
  filename = "${path.module}/site/index.html"
  content = replace(
    replace(
      replace(file("${path.module}/../../app/index.html"), "__COMMIT__", var.commit),
      "__VERSION__", var.app_version
    ),
    "__ENVIRONMENT__", var.environment
  )
}

output "url" {
  description = "NO-CLOUD mode: the page is a run artifact named site-<env>."
  value       = "artifact site-${var.environment} (no-cloud mode)"
}
