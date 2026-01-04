# Databricks Resources - Production Environment
# Managed by Toyota Data Engineering Portal
# Environment: prod

# This file will be populated by the Backstage onboarding workflow
# when Databricks resources are provisioned for the Production environment.

terraform {
  required_providers {
    databricks = {
      source  = "databricks/databricks"
      version = "~> 1.30"
    }
  }
}

# Resources will be added here by the onboarding workflow
