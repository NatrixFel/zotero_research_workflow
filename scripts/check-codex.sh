#!/usr/bin/env bash
# Check that Node.js, npm, and Codex CLI are available, and ask Codex for
# login status. This script never opens or prints ~/.codex/auth.json.
set -u

fail=0

echo "Codex environment check"
echo "Auth file contents are not read or printed."
echo

if command -v node >/dev/null 2>&1; then
  echo "node: $(node --version)"
else
  echo "node: not found"
  fail=1
fi

if command -v npm >/dev/null 2>&1; then
  echo "npm: $(npm --version)"
else
  echo "npm: not found"
  fail=1
fi

if command -v codex >/dev/null 2>&1; then
  echo "codex: $(command -v codex)"
  version="$(codex --version 2>&1 | head -n 1 || true)"
  if [[ -n "$version" ]]; then
    echo "codex version: $version"
  fi
else
  echo "codex: not found"
  echo "Install with: npm install -g @openai/codex"
  fail=1
fi

auth_file="${HOME}/.codex/auth.json"
if [[ -e "$auth_file" || -L "$auth_file" ]]; then
  if [[ -L "$auth_file" ]]; then
    echo "auth file: present as a symlink at ~/.codex/auth.json (contents not shown)"
  else
    mode="$(stat -c '%a' "$auth_file" 2>/dev/null || echo "unknown")"
    echo "auth file: present at ~/.codex/auth.json (mode ${mode}; contents not shown)"
    if [[ "$mode" != "unknown" && "$mode" != "600" ]]; then
      echo "auth file mode is not 600. Leave the file in place and tighten permissions locally if needed."
    fi
  fi
else
  echo "auth file: not present at ~/.codex/auth.json"
fi

echo
if command -v codex >/dev/null 2>&1; then
  echo "codex login status:"
  if ! codex login status; then
    echo "Login status check failed. Authorize with: codex login"
    fail=1
  fi
fi

exit "$fail"
