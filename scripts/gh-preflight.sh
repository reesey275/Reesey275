#!/usr/bin/env bash
set -euo pipefail

GH_TOKEN="${CI_PROFILE_PUSH_TOKEN:-$CODEX_AGENT_AUTH}"
if ! gh auth status >/dev/null 2>&1 && [ -n "$GH_TOKEN" ]; then
  echo "$GH_TOKEN" | gh auth login --with-token
fi
