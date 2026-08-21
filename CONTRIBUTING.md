# Contributing

Thanks for your interest in contributing to the Terraform Azure Landing Zone project!

## Prerequisites

- [Terraform >= 1.5.0](https://developer.hashicorp.com/terraform/install)
- [Azure CLI](https://learn.microsoft.com/en-us/cli/azure/install-azure-cli)
- [Git](https://git-scm.com/)
- An Azure subscription (for testing)

## Getting Started

```bash
git clone https://github.com/Harshithj88/terraform-azure-landing-zone.git
cd terraform-azure-landing-zone
```

### Validate modules

```bash
cd environments/dev
terraform init
terraform validate
terraform fmt -check -recursive ../../modules
```

## How to Contribute

1. **Fork** the repository
2. Create a **feature branch** (`git checkout -b feat/your-feature`)
3. Make changes and validate locally
4. Run `terraform fmt -recursive` before committing
5. **Commit** with a descriptive message
6. **Push** and open a Pull Request

## Commit Message Format

- `feat:` — new module or feature
- `fix:` — bug fix
- `docs:` — documentation only
- `refactor:` — restructuring without behavior change
- `test:` — adding or updating tests
- `chore:` — CI, configs, dependencies

## Module Guidelines

- Each module lives in `modules/<name>/` with `main.tf`, `variables.tf`, `outputs.tf`
- All variables must have `description` and `type`
- Use `default` values where sensible
- Mark sensitive outputs with `sensitive = true`
- Follow [Azure naming conventions](https://learn.microsoft.com/en-us/azure/cloud-adoption-framework/ready/azure-best-practices/resource-naming)
