#!/usr/bin/env bash
# Copy SAT migration scripts into supabase/migrations/ so Supabase CLI can run them.
# Run from repo root: ./supabase/sat-migrations/sync-to-migrations.sh

set -e
SCRIPT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
MIGRATIONS_DIR="$(dirname "$SCRIPT_DIR")/migrations"
cp -v "$SCRIPT_DIR"/*.sql "$MIGRATIONS_DIR/"
echo "Done. Run: supabase db push"
