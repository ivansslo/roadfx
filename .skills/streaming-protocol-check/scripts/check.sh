#!/usr/bin/env bash
# streaming-protocol-check: verify streaming protocol consistency
set -euo pipefail

REPO_ROOT="$(cd "$(dirname "$0")/../../.." && pwd)"
cd "$REPO_ROOT"

CHANGED_FILES=$(git diff --name-only HEAD 2>/dev/null || git diff --name-only --cached)
if [ -z "$CHANGED_FILES" ]; then
  echo "✓ No changes detected"
  exit 0
fi

# Check for streaming-related changes
STREAM_FILES=$(echo "$CHANGED_FILES" | grep -iE '(streaming/|stream|sse|wukongim|json.?render|MixedStream)' || true)

if [ -z "$STREAM_FILES" ]; then
  echo "✓ No streaming-related changes detected"
  exit 0
fi

echo "Streaming-related changes detected:"
echo "$STREAM_FILES" | sed 's/^/  /'
echo ""

echo "## Files to check for consistency"
echo ""

# Producer side (roadfx-ai)
echo "### Producer: roadfx-ai"
echo "  Streaming output:"
find repos/roadfx-ai -path "*/streaming/*" -type f 2>/dev/null | sed 's/^/    /' || echo "    (no streaming dir)"
echo "  Chat service:"
find repos/roadfx-ai -name "chat_service.py" -type f 2>/dev/null | sed 's/^/    /' || true
echo ""

# API relay (roadfx-api)
echo "### Relay: roadfx-api"
find repos/roadfx-api -name "*chat*" -o -name "*stream*" 2>/dev/null | grep -v __pycache__ | grep -v node_modules | sed 's/^/    /' || true
echo ""

# Consumer: roadfx-web
echo "### Consumer: roadfx-web"
echo "  Chat components:"
find repos/roadfx-web/src -path "*/chat/*" -type f 2>/dev/null | head -10 | sed 's/^/    /' || true
echo "  json-render:"
find repos/roadfx-web/src -path "*/jsonRender/*" -type f 2>/dev/null | sed 's/^/    /' || true
echo "  Stores:"
find repos/roadfx-web/src -name "*chatStore*" -o -name "*messageStore*" 2>/dev/null | sed 's/^/    /' || true
echo ""

# Consumer: roadfx-widget-js
echo "### Consumer: roadfx-widget-js"
echo "  Chat store:"
find repos/roadfx-widget-js/src -name "chatStore*" -type f 2>/dev/null | sed 's/^/    /' || true
echo "  json-render:"
find repos/roadfx-widget-js/src -path "*/jsonRender/*" -type f 2>/dev/null | sed 's/^/    /' || true
echo "  Messages:"
find repos/roadfx-widget-js/src -path "*/messages/*" -type f 2>/dev/null | sed 's/^/    /' || true
echo ""

# Consumer: roadfx-widget-miniprogram
echo "### Consumer: roadfx-widget-miniprogram"
echo "  Chat store:"
find repos/roadfx-widget-miniprogram/src -name "chatStore*" -type f 2>/dev/null | sed 's/^/    /' || true
echo "  json-render:"
find repos/roadfx-widget-miniprogram/src -path "*/json-render*" -type f 2>/dev/null | sed 's/^/    /' || true
echo ""

echo "## Protocol Contract (do not break)"
echo "  - SSE chunk format: data: {json}\\n\\n"
echo "  - Stream events: stream.delta, stream.close, stream.error"
echo "  - json-render: \`\`\`spec fence → JSONL patches"
echo "  - MixedStreamParser input/output must be consistent across all consumers"
