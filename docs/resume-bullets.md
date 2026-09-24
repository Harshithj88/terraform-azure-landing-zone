# Resume Bullets

- Designed and built an Azure landing zone using Terraform with a hub-spoke network topology, provisioning VNets, subnets, NSGs, Key Vault, Log Analytics, AKS, and Azure Policy across dev and prod environments.

- Authored reusable Terraform modules (storage account, NSG, private DNS zone, container registry) with input validation, sensible security defaults, and per-module documentation.

- Implemented security-hardened defaults across modules: TLS 1.2 enforcement, disabled public blob access, RBAC-only Key Vault, deny-all NSG baselines, and CanNotDelete management locks.

- Integrated static analysis and policy-as-code into CI/CD using GitHub Actions, running Terraform validate, TFLint, Checkov, tfsec, and Trivy with SARIF results published to the GitHub Security tab.

- Established remote state management in Azure Storage with versioning, TLS enforcement, and delete locks to protect infrastructure state integrity.

- Enforced governance with Azure Policy definitions that deny public IPs and restrict VM SKUs in production, aligning deployments with organizational compliance requirements.

- Standardized provider and version constraints via a root `versions.tf`, pinning Terraform, AzureRM, AzureAD, and Random providers to compatible ranges for reproducible deployments.

- Configured private DNS zones with VNet links to support private endpoint name resolution, enabling private connectivity to PaaS services without public exposure.

- Documented deployment workflows, architecture, and security policy (SECURITY.md), and set up pre-commit hooks (terraform fmt, tflint, terraform-docs) to enforce quality before commits.
