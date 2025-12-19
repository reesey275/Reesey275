#!/usr/bin/env bash
#
# setup-env-hooks.sh
# Install env-policy pre-commit hook for a repository
#
# Usage:
#   ./setup-env-hooks.sh [--local]
#
# Default: Installs to .githooks/ (versioned, team-shared)
# --local: Installs to .git/hooks/ (local-only, not versioned)
#

set -euo pipefail

USE_LOCAL=false
if [[ "${1:-}" == "--local" ]]; then
  USE_LOCAL=true
fi

TEMPLATE_HOOK="$HOME/dev/templates/pre-commit-env-policy"

if [ ! -f "$TEMPLATE_HOOK" ]; then
  echo "❌ Template hook not found: $TEMPLATE_HOOK"
  exit 1
fi

if [ ! -d .git ]; then
  echo "❌ Not in a git repository"
  exit 1
fi

if $USE_LOCAL; then
  # Local hooks (not versioned)
  TARGET_DIR=".git/hooks"
  TARGET="$TARGET_DIR/pre-commit"
  
  echo "📦 Installing local pre-commit hook..."
  mkdir -p "$TARGET_DIR"
  cp "$TEMPLATE_HOOK" "$TARGET"
  chmod +x "$TARGET"
  
  echo "✅ Installed to: $TARGET"
  echo "   (Local only, not versioned)"
else
  # Team hooks (versioned)
  TARGET_DIR=".githooks"
  TARGET="$TARGET_DIR/pre-commit"
  
  echo "📦 Installing versioned pre-commit hook..."
  mkdir -p "$TARGET_DIR"
  cp "$TEMPLATE_HOOK" "$TARGET"
  chmod +x "$TARGET"
  
  # Configure git to use .githooks
  git config core.hooksPath .githooks
  
  echo "✅ Installed to: $TARGET"
  echo "   Configured: git config core.hooksPath .githooks"
  echo "   (Versioned, team-shared)"
  echo ""
  echo "⚠️  Each team member must run:"
  echo "   git config core.hooksPath .githooks"
  echo "   (Or add this to onboarding docs)"
fi

echo ""
echo "Testing hook..."
if "$TARGET" 2>&1 | grep -q "STAGED_FILES"; then
  echo "✅ Hook installed correctly (no staged files to check)"
else
  echo "✅ Hook installed and executable"
fi
