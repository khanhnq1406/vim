#!/bin/bash
# Sync dev → main, automatically excluding AI-related files
set -e

# Files/patterns to exclude from main
EXCLUDE=(
  "CLAUDE.md"
  ".claude/"
  "scripts/sync-to-main.sh"
)

CURRENT_BRANCH=$(git branch --show-current)
if [ "$CURRENT_BRANCH" != "dev" ]; then
  echo "Error: Run this from the dev branch"
  exit 1
fi

# Stash any uncommitted changes
STASHED=false
if ! git diff --quiet || ! git diff --cached --quiet; then
  git stash push -m "sync-to-main: temp stash"
  STASHED=true
fi

# Switch to main and reset it to match dev
git checkout main
git reset --hard dev

# Remove AI-related files
for pattern in "${EXCLUDE[@]}"; do
  git rm -rf --ignore-unmatch "$pattern"
done

# Amend the commit to exclude those files
git commit --amend -m "Sync from dev ($(git log dev -1 --format='%h'))"

# Go back to dev
git checkout dev

# Restore stash if needed
if [ "$STASHED" = true ]; then
  git stash pop
fi

echo ""
echo "Done! main is now synced with dev (minus AI files)."
echo "Run 'git push origin main' when ready to publish."
