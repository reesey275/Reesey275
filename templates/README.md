# reesey275 Developer Templates

Versioned templates for environment configuration and git hooks across all projects.

## Quick Start

### For New Projects

```bash
# From your new repo root:
curl -O https://raw.githubusercontent.com/reesey275/reesey275/main/templates/hooks/setup-env-hooks.sh
chmod +x setup-env-hooks.sh
./setup-env-hooks.sh
```

Or clone this repo and copy:
```bash
git clone git@github.com:reesey275/reesey275.git
cd your-new-project
cp ../reesey275/templates/hooks/setup-env-hooks.sh .
./setup-env-hooks.sh
```

### For Existing Projects

```bash
# Install hooks
cp /path/to/reesey275/templates/hooks/pre-commit-env-policy .githooks/pre-commit
chmod +x .githooks/pre-commit
git config core.hooksPath .githooks

# Copy env templates
cp /path/to/reesey275/templates/.env.TEMPLATE.template .env.TEMPLATE
cp /path/to/reesey275/templates/.env.example.template .env.example

# Customize for your project
# Then commit both templates
git add .env.TEMPLATE .env.example
```

## Files

### Hooks
- **`hooks/pre-commit-env-policy`** — Fail-closed env file checker (canonical version)
- **`hooks/setup-env-hooks.sh`** — Automated installer for pre-commit hooks

### Environment Templates
- **`.env.TEMPLATE.template`** — Comprehensive documented env file starter
- **`.env.example.template`** — Lean env file starter (no comments)

## CI Integration

Copy `.github/workflows/env-policy-check.yml` to enable CI-level enforcement:

```bash
mkdir -p .github/workflows
cp /path/to/reesey275/.github/workflows/env-policy-check.yml .github/workflows/
```

This ensures no forbidden `.env` files bypass local hooks and make it into the repo.

## Policy Reference

See full documentation:
- **Policy**: `~/dev/ENV_CONFIGURATION_POLICY.md` (local reference)
- **Hardening Report**: `~/dev/ENV_HOOKS_HARDENED.md`
- **Portability Guide**: `~/dev/PORTABLE_GOVERNANCE.md`

## Version History

- **2025-12-18**: Initial versioned templates (fail-closed hooks, CI guardrail)
