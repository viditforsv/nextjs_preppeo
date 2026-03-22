#!/usr/bin/env bash
# Sync migrations to the remote DEV Supabase project.
#
# Usage:
#   ./scripts/sync-dev-db.sh          # push pending migrations
#   ./scripts/sync-dev-db.sh --diff   # show schema diff (remote vs local)
#   ./scripts/sync-dev-db.sh --status # show migration status
#
# Prerequisites:
#   brew install supabase/tap/supabase  (or npm i -g supabase)
#   supabase login

set -euo pipefail
cd "$(dirname "$0")/.."

# Load .env.local for the dev DB password (if needed)
if [ -f .env.local ]; then
  set -a; source .env.local; set +a
fi

DEV_PROJECT_REF="dxhxpfouzjlzpeazwrqo"
PROD_PROJECT_REF="ootnqmojcqnzfrtvzzec"

echo "Target: DEV Supabase ($DEV_PROJECT_REF)"
echo ""

case "${1:-push}" in
  --diff)
    echo "Generating schema diff (remote DEV vs local migrations)..."
    supabase db diff --linked --project-ref "$DEV_PROJECT_REF"
    ;;
  --status)
    echo "Migration status on DEV..."
    supabase migration list --project-ref "$DEV_PROJECT_REF"
    ;;
  push|--push)
    echo "Pushing pending migrations to DEV..."
    supabase db push --project-ref "$DEV_PROJECT_REF"
    echo ""
    echo "Done. Dev DB is up to date."
    ;;
  *)
    echo "Unknown option: $1"
    echo "Usage: $0 [--push|--diff|--status]"
    exit 1
    ;;
esac
