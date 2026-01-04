# Databricks Infrastructure - Terragrunt

This repository manages Databricks resources (schemas, tables, SQL warehouses, clusters, pipelines) using Terraform/Terragrunt with a GitOps workflow.

## Repository Structure

```
bs-dbx-terragrunt/
├── .github/
│   └── workflows/
│       └── databricks-apply.yml    # CI/CD workflow for deployments
├── environments/
│   ├── dev/
│   │   └── terragrunt.hcl          # Dev environment resources
│   ├── qa/
│   │   └── terragrunt.hcl          # QA environment resources
│   └── prod/
│       └── terragrunt.hcl          # Production environment resources
└── README.md
```

## Branching Strategy

This repository follows a multi-environment branching strategy:

| Branch    | Environment | Purpose                                    |
|-----------|-------------|-------------------------------------------|
| `develop` | dev         | Development environment                    |
| `release` | qa          | QA/Staging environment                     |
| `master`  | prod        | Production environment                     |

## Deployment Workflow

1. **Onboarding Portal** creates a PR with Databricks resource configurations
2. **Code Review** (optional - currently set to 0 approvals for personal account)
3. **PR Merge** triggers automatic deployment to the target environment
4. **GitHub Actions** applies Terraform configuration to Databricks workspace
5. **Status Update** reflected in Backstage portal

### Workflow Triggers

- PR merged to `develop` → deploys to **dev** environment
- PR merged to `release` → deploys to **qa** environment
- PR merged to `master` → deploys to **prod** environment

## Resource Types Supported

- **Schemas**: Unity Catalog schemas
- **Tables**: Delta tables with partitioning and CDF support
- **SQL Warehouses**: Serverless SQL endpoints
- **Clusters**: Interactive clusters for notebooks
- **DLT Pipelines**: Delta Live Tables pipelines

## Configuration

### GitHub Secrets Required

| Secret                    | Description                           |
|---------------------------|---------------------------------------|
| `DATABRICKS_HOST`         | Databricks workspace URL              |
| `DATABRICKS_TOKEN`        | Databricks personal access token      |

### Environment Variables

Resources are configured per environment in `environments/{env}/terragrunt.hcl`:

- **dev**: Development workspace
- **qa**: QA/Staging workspace
- **prod**: Production workspace

## Usage

### Via Backstage Onboarding Portal

1. Navigate to **Application Onboarding** in Backstage
2. Select desired Databricks resources
3. Configure resource parameters
4. Submit onboarding request
5. PR is automatically created
6. Merge PR to deploy

### Manual Deployment

```bash
# Navigate to environment directory
cd environments/dev

# Initialize Terraform
terraform init

# Plan changes
terraform plan

# Apply changes
export DATABRICKS_HOST="https://your-workspace.cloud.databricks.com"
export DATABRICKS_TOKEN="your-token"
terraform apply
```

## File Path Template

Resources are organized by environment:

```
environments/{environment}/terragrunt.hcl
```

Examples:
- `environments/dev/terragrunt.hcl` - All dev resources
- `environments/qa/terragrunt.hcl` - All QA resources
- `environments/prod/terragrunt.hcl` - All prod resources

## Databricks Workspace

**URL**: https://dbc-32863125-bd1b.cloud.databricks.com/

**Catalog**: `depss-poc-catlog`

## Terraform Provider

Uses the official Databricks Terraform provider:

```hcl
terraform {
  required_providers {
    databricks = {
      source  = "databricks/databricks"
      version = "~> 1.30"
    }
  }
}
```

## Managed By

Toyota Data Engineering Portal (Backstage)
