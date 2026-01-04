# Databricks Resources - QA Environment
# Managed by Toyota Data Engineering Portal
# Environment: qa

# This file will be populated by the Backstage onboarding workflow
# when Databricks resources are provisioned for the QA environment.

terraform {
  required_providers {
    databricks = {
      source  = "databricks/databricks"
      version = "~> 1.30"
    }
  }
}

# Resources will be added here by the onboarding workflow
