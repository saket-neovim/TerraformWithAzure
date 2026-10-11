# Terraform Operations Labs on Azure

Focused HCL exercises for understanding Terraform plan behavior, resource dependencies, replacement, state, imports, and stable resource addresses on Azure.

**Status:** these are learning configurations, with no committed deployment/test evidence. Some exercises require existing resources or intentionally altered state; review the selected root before running a plan.

## Lab guide

| Directory | Focus |
| --- | --- |
| [01 — Predicting plans](01-predicting-terraform-plans-before-you-run-them/) | Known values, outputs, and plan prediction |
| [02 — Dependencies](02-implicit-vs-explicit-dependencies/) | Resource references and dependency ordering |
| [03 — Replacement](03-replacement-and-immutable-azure-properties/) | Immutable properties and replacement behavior |
| [04 — Data-source timing](04-unknown-values-and-data-source-timing/) | Values resolved before and during apply |
| [05 — Stable addresses](05-count-vs-for-each-and-address-stability/) | Index-based versus key-based addressing |
| [06 — State and imports](06-local-state-forensics-and-lab-07/) | State inspection and importing an existing storage account |
| [08 — Renaming](08-renaming-terraform-without-renaming-azure/) | Refactoring Terraform addresses |
| [09 — Module moves](09-moving-resources-into-modules-safely/) | Moving resource ownership into modules |
| [10 — Remote state](10-remote-state-locking-and-recovery/) | Azure Storage backend configuration |
| [11 — Complex inputs](11-complex-inputs-for-subnets/) | Structured subnet inputs |

The numbering follows the original exercise sequence; there is no standalone Lab 07 folder.

## Prerequisites and usage

Install Terraform, Git, and Azure CLI. Inspect the selected root's `versions.tf` and `.terraform.lock.hcl` for version requirements. Use a disposable Azure environment with permission to manage the selected resources.

```bash
az login
az account set --subscription '<your-subscription-id>'
export ARM_SUBSCRIPTION_ID="$(az account show --query id -o tsv)"
export ARM_TENANT_ID="$(az account show --query tenantId -o tsv)"
cd 01-predicting-terraform-plans-before-you-run-them
terraform init
terraform fmt -check
terraform validate
```

Set required inputs in an ignored `terraform.tfvars` file. For Lab 01, supply `prefix`, `location`, `tags`, and an Azure-valid, globally unique `storage_account` name. Then run `terraform plan -out=tfplan` and compare the result with your prediction before any apply.

### Existing resources and backends

Lab 06 requires `import_storage_account_id`, the full resource ID of an existing account. Its account name and resource group must match the configuration. Import associates state with an existing resource; a mismatched configuration can still propose destructive changes.

Lab 10 requires an existing state storage account/container. Copy [backend.hcl.example](10-remote-state-locking-and-recovery/backend.hcl.example) to ignored `backend.hcl` in that directory, set your own coordinates, then use:

```bash
terraform init -backend-config=backend.hcl
```

Do not migrate or replace an existing backend without reviewing the current state location and keeping a protected backup.

## Review and validation

Explain a concrete before/after plan: which address changes, what gets replaced, and what remains the same Azure resource. Formatting and validation do not verify Azure permissions, backend access, import safety, or successful deployments.

The dependency images in Labs 02 and 03 show configuration references, not proof of successful execution. Save redacted observations rather than state or full plan files.

## Cleanup and security

Run a reviewed destroy plan only for disposable resources owned by the selected state. Decide separately whether imported resources and backend storage should be retained; Terraform can destroy an imported resource once it is managed.

Keep account IDs and backend coordinates local. Never commit `.tfvars`, state, plans, credentials, or secret output. Keep lock files and safe examples tracked. This repository demonstrates Terraform mechanics rather than a production platform or CI/CD pipeline.
