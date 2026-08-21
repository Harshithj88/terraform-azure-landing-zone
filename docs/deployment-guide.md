# Deployment Guide

## Prerequisites

- Azure subscription with Owner or Contributor + User Access Administrator role
- [Terraform >= 1.5.0](https://developer.hashicorp.com/terraform/install)
- [Azure CLI](https://learn.microsoft.com/en-us/cli/azure/install-azure-cli)
- GitHub repository with OIDC configured for Azure

## 1. Configure OIDC Authentication

Create a federated credential for GitHub Actions:

```bash
# Create an app registration
az ad app create --display-name "terraform-landing-zone-gh"

# Create a service principal
az ad sp create --id <APP_ID>

# Add federated credential for main branch
az ad app federated-credential create --id <APP_ID> --parameters '{
  "name": "github-main",
  "issuer": "https://token.actions.githubusercontent.com",
  "subject": "repo:Harshithj88/terraform-azure-landing-zone:ref:refs/heads/main",
  "audiences": ["api://AzureADTokenExchange"]
}'

# Add federated credential for pull requests
az ad app federated-credential create --id <APP_ID> --parameters '{
  "name": "github-pr",
  "issuer": "https://token.actions.githubusercontent.com",
  "subject": "repo:Harshithj88/terraform-azure-landing-zone:pull_request",
  "audiences": ["api://AzureADTokenExchange"]
}'

# Grant Contributor role on the subscription
az role assignment create \
  --assignee <APP_ID> \
  --role Contributor \
  --scope /subscriptions/<SUBSCRIPTION_ID>
```

## 2. Initialize State Backend

```bash
chmod +x scripts/init-backend.sh
./scripts/init-backend.sh dev
./scripts/init-backend.sh prod
```

## 3. Set GitHub Secrets

| Secret | Value |
|--------|-------|
| `AZURE_CLIENT_ID` | App registration client ID |
| `AZURE_SUBSCRIPTION_ID` | Target subscription ID |
| `AZURE_TENANT_ID` | Azure AD tenant ID |

## 4. Deploy

### Via CI/CD (recommended)

1. Create a feature branch
2. Push changes to modules or environments
3. Open a PR → `terraform-plan.yml` runs automatically and posts the plan
4. Merge to `main` → `terraform-apply.yml` deploys dev automatically
5. Use `workflow_dispatch` to deploy prod manually

### Locally (for development)

```bash
cd environments/dev
az login
terraform init
terraform plan
terraform apply
```

## Environment Differences

| Setting | Dev | Prod |
|---------|-----|------|
| AKS SKU | Free | Standard |
| System nodes | 1-3 × D2s_v5 | 2-5 × D4s_v5 |
| User node pool | Disabled | 2-10 × D4s_v5 |
| Bastion | Disabled | Enabled |
| Log retention | 30 days | 90 days |
| Budget | $500/mo | $3,000/mo |
| Public IP policy | Allowed | Denied |
| VM SKU restriction | None | D2s/D4s/D8s_v5 only |

## Destroying Infrastructure

```bash
cd environments/dev
terraform destroy
```

> **Warning**: Prod has a budget resource with delete protection. Remove the lock first if destroying.
