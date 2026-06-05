---
name: functional-verification
description: Use roadfx-cli (staff) and roadfx-widget-cli (visitor) to verify API and service changes at runtime, beyond static lint/build checks. Trigger after modifying backend API endpoints, service logic, chat flow, agent config, knowledge/RAG, workflow, or platform integration — requires local services to be running. Auto-detects changed services from git diff and runs the corresponding CLI smoke tests (system info, CRUD listing, chat e2e).
---

# functional-verification

## Purpose
Use roadfx-cli (staff) and roadfx-widget-cli (visitor) to verify API/service changes at runtime — beyond static lint/build checks.

## Trigger
After modifying backend API endpoints, service logic, chat flow, agent config, knowledge/RAG, workflow, or platform integration — when local services are running.

## Prerequisites
- Local services must be running (`make dev-all` or individual `make dev-*`)
- roadfx-cli configured (`~/.roadfx/config.json` with server + token, via `roadfx auth login`)
- roadfx-widget-cli configured (`~/.roadfx-widget/config.json`, via `roadfx-widget init`)

## What it does
1. Checks CLI build status and config availability
2. Verifies server reachability
3. Based on `git diff`, maps changed services to verification commands:

| Changed Service | Verification |
|----------------|-------------|
| roadfx-api | `roadfx system info`, `roadfx auth whoami`, `roadfx conversation list --limit 1` |
| roadfx-ai | `roadfx chat team --message "ping"`, `roadfx agent list --limit 1` |
| roadfx-rag | `roadfx knowledge list --limit 1` |
| roadfx-workflow | `roadfx workflow list --limit 1` |
| roadfx-platform | `roadfx platform list` |
| roadfx-api + visitor flow | `roadfx-widget platform info`, `roadfx-widget chat send --message "ping" --no-stream` |

4. Outputs pass/fail per check

## Usage
```bash
# Auto-detect from git diff
bash .skills/functional-verification/scripts/verify.sh

# Target specific service
bash .skills/functional-verification/scripts/verify.sh roadfx-api

# Full smoke test (all checks)
bash .skills/functional-verification/scripts/verify.sh --all
```

## Manual verification commands

### Staff-side (roadfx-cli)
```bash
ROADFX_CLI="node repos/roadfx-cli/dist/index.js"

# System health
$ROADFX_CLI system info
$ROADFX_CLI auth whoami

# Chat e2e (sends to AI, gets response)
$ROADFX_CLI chat team --message "say ok"

# CRUD verification
$ROADFX_CLI agent list
$ROADFX_CLI provider list
$ROADFX_CLI knowledge list
$ROADFX_CLI workflow list
$ROADFX_CLI conversation list --limit 1
$ROADFX_CLI visitor list --limit 1
$ROADFX_CLI platform list
$ROADFX_CLI staff list
```

### Visitor-side (roadfx-widget-cli)
```bash
ROADFX_WIDGET_CLI="node repos/roadfx-widget-cli/dist/index.js"

# Platform & channel
$ROADFX_WIDGET_CLI platform info
$ROADFX_WIDGET_CLI channel info

# Chat e2e (visitor sends, AI responds via SSE)
$ROADFX_WIDGET_CLI chat send --message "say ok" --no-stream

# History
$ROADFX_WIDGET_CLI chat history --limit 3
```
