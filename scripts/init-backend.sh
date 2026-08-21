#!/bin/bash
set -euo pipefail

# Initialize Azure Storage backend for Terraform state
# Usage: ./init-backend.sh <environment> <location>

ENVIRONMENT="${1:?Usage: $0 <environment> <location>}"
LOCATION="${2:-westus2}"

RESOURCE_GROUP="rg-terraform-state"
STORAGE_ACCOUNT="stterraformstate${ENVIRONMENT}"
CONTAINER_NAME="tfstate"

echo "=== Creating Terraform backend for '${ENVIRONMENT}' ==="

echo "Creating resource group: ${RESOURCE_GROUP}"
az group create \
  --name "${RESOURCE_GROUP}" \
  --location "${LOCATION}" \
  --tags environment=shared project=terraform-state managed_by=script

echo "Creating storage account: ${STORAGE_ACCOUNT}"
az storage account create \
  --name "${STORAGE_ACCOUNT}" \
  --resource-group "${RESOURCE_GROUP}" \
  --location "${LOCATION}" \
  --sku Standard_LRS \
  --kind StorageV2 \
  --min-tls-version TLS1_2 \
  --allow-blob-public-access false \
  --https-only true \
  --tags environment=shared project=terraform-state

echo "Creating blob container: ${CONTAINER_NAME}"
az storage container create \
  --name "${CONTAINER_NAME}" \
  --account-name "${STORAGE_ACCOUNT}" \
  --auth-mode login

echo "Enabling versioning for state recovery"
az storage account blob-service-properties update \
  --account-name "${STORAGE_ACCOUNT}" \
  --resource-group "${RESOURCE_GROUP}" \
  --enable-versioning true

echo "Adding delete lock to prevent accidental removal"
az lock create \
  --name "tfstate-nodelete" \
  --resource-group "${RESOURCE_GROUP}" \
  --lock-type CanNotDelete \
  --notes "Protects Terraform state storage"

echo ""
echo "=== Backend ready ==="
echo "Resource Group:  ${RESOURCE_GROUP}"
echo "Storage Account: ${STORAGE_ACCOUNT}"
echo "Container:       ${CONTAINER_NAME}"
echo ""
echo "Run 'terraform init' in environments/${ENVIRONMENT}/ to connect."
