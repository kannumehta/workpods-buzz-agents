#!/usr/bin/env bash
set -euo pipefail

repo_root=$(cd "$(dirname "${BASH_SOURCE[0]}")/../.." && pwd)
validator="$repo_root/pods/scripts/validate-auth-state"
tmp=$(mktemp -d)
trap 'sudo rm -rf "$tmp"' EXIT

mkdir -p "$tmp/state/profile"
printf '%s\n' \
  'OPENAI_API_KEY=not-a-real-secret' \
  'OPENAI_BASE_URL=http://workpods-llm-gateway:8080/v1' > "$tmp/gateway.env"
cat > "$tmp/state/profile/auth.json" <<'JSON'
{"version":1,"providers":{},"credential_pool":{"openai-api":[{"id":"env-1","label":"OPENAI_API_KEY","auth_type":"api_key","priority":0,"source":"env:OPENAI_API_KEY","last_status":null,"last_status_at":null,"last_error_code":null,"last_error_reason":null,"last_error_message":null,"last_error_reset_at":null,"base_url":"http://workpods-llm-gateway:8080/v1","request_count":1,"secret_fingerprint":"metadata-only"}]},"updated_at":"2026-08-21T00:00:00Z"}
JSON
sudo chown -R 10000:10000 "$tmp/state"
sudo chmod 0600 "$tmp/state/profile/auth.json"
sudo "$validator" "$tmp/state" "$tmp/gateway.env" >/dev/null

sudo python3 - "$tmp/state/profile/auth.json" <<'PY'
import json
import sys
from pathlib import Path

path = Path(sys.argv[1])
data = json.loads(path.read_text())
data["providers"] = {"openai-codex": {"access_token": "forbidden"}}
path.write_text(json.dumps(data))
PY
sudo chmod 0600 "$tmp/state/profile/auth.json"
if sudo "$validator" "$tmp/state" "$tmp/gateway.env" >/dev/null 2>&1; then
  echo "validator accepted direct provider auth" >&2
  exit 1
fi

echo "auth-state tests passed"
