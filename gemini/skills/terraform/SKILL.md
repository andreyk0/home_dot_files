---
name: terraform
description: Manage infrastructure using Terraform. Use for planning changes, formatting code, and understanding infrastructure state. NEVER apply changes.
---

# Terraform

This skill provides safe guidelines for interacting with Terraform infrastructure.

## Critical Safety Rules

1.  **NO STATE CHANGES**: You are strictly FORBIDDEN from running `terraform apply`, `terraform destroy`, `terraform import`, or any command that modifies remote state.
2.  **PLAN ONLY**: You may run `terraform plan` to preview changes, but be aware it may fail due to permissions.
3.  **DEV ONLY**: Planning is generally only successful for development environments.
4.  **FORMATTING**: always run `terraform fmt` after making changes to `.tf` files.

## Workflow

1.  **Check Tools**: detailed instructions on how to use `mise` or `just` are below.
2.  **Plan**: Run `terraform plan` (via `mise` or `just`) to validate changes.
3.  **Format**: Run `terraform fmt` (via `mise` or `just`) to ensure code style.

## Tools

*   **mise**: Use `mise x -- terraform ...` to ensure correct versioning.
*   **just**: Check `justfile` for pre-defined terraform tasks (e.g. `just terraform-plan`).

## Troubleshooting

*   **Permissions**: If `plan` fails with permission errors, stop and report to the user. Do not attempt to bypass.
*   **State Lock**: If state is locked, do not force unlock. Report to user.
