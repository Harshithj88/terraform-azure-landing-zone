# Security Policy

## Reporting a Vulnerability

If you discover a security vulnerability in this project, please report it responsibly:

1. **Do not** open a public GitHub issue
2. Email [harsh.julapelli@gmail.com](mailto:harsh.julapelli@gmail.com) with:
   - Description of the vulnerability
   - Steps to reproduce
   - Potential impact
3. You will receive a response within 48 hours

## Security Design

This project follows Azure security best practices:

- **OIDC authentication** — No stored credentials in CI/CD; GitHub Actions uses federated identity
- **RBAC authorization** — Key Vault uses role-based access control, not access policies
- **Network isolation** — Hub-spoke topology with NSG deny-all defaults and private endpoints
- **Policy enforcement** — Azure Policy denies public IPs and restricts VM SKUs in production
- **State protection** — Remote state in Azure Storage with versioning, TLS 1.2, and delete locks
- **Least privilege** — Managed identities for AKS; scoped role assignments

## Sensitive Data

- Never commit `.tfvars` files containing real secrets, subscription IDs, or tenant IDs
- Use `sensitive = true` on Terraform outputs that expose keys or connection strings
- The `.gitignore` excludes `*.tfstate`, `*.tfstate.backup`, and `crash.log`
