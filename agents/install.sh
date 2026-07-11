#!/usr/bin/env bash

set -euo pipefail

SCRIPT_DIR="$(cd -- "$(dirname -- "${BASH_SOURCE[0]}")" && pwd)"
SKILLS_FILE="$SCRIPT_DIR/skills.txt"

SKILL_URLS=()

while IFS= read -r skill_url || [[ -n "$skill_url" ]]; do
  SKILL_URLS+=("$skill_url")
done < "$SKILLS_FILE"

for skill_url in "${SKILL_URLS[@]}"; do
  skill_url="${skill_url//$'\r'/}"

  [[ -z "$skill_url" || "$skill_url" == \#* ]] && continue

  echo "Installing $skill_url..."

  npx skills add "$skill_url" \
    --agent codex \
    --agent claude-code \
    --global \
    --yes \
    </dev/null
done
