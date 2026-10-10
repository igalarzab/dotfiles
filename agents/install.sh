#!/usr/bin/env bash

set -euo pipefail

SCRIPT_DIR="$(cd -- "$(dirname -- "${BASH_SOURCE[0]}")" && pwd)"
SKILLS_FILE="$SCRIPT_DIR/skills.txt"

link_skill() {
  local source="$1" destination="$2"

  if [[ -e "$destination" && ! -L "$destination" ]]; then
    echo "Remove $destination before linking the local skill" >&2
    return 1
  fi

  mkdir -p "$(dirname "$destination")"
  ln -sfn "$source" "$destination"
}

SKILL_URLS=()

while IFS= read -r skill_url || [[ -n "$skill_url" ]]; do
  SKILL_URLS+=("$skill_url")
done < "$SKILLS_FILE"

for skill_url in "${SKILL_URLS[@]}"; do
  skill_url="${skill_url//$'\r'/}"

  [[ -z "$skill_url" || "$skill_url" == \#* ]] && continue

  npx skills add "$skill_url" \
    --agent codex \
    --agent claude-code \
    --global \
    --yes \
    >/dev/null \
    </dev/null
done

for skill_file in "$SCRIPT_DIR"/skills/*/SKILL.md; do
  [[ -f "$skill_file" ]] || continue
  skill_dir="$(dirname "$skill_file")"
  skill_name="$(basename "$skill_dir")"
  shared_skill="$HOME/.agents/skills/$skill_name"

  link_skill "$skill_dir" "$shared_skill"
  link_skill "$shared_skill" "$HOME/.claude/skills/$skill_name"
done
