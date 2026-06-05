# roadfx-ai — AGENTS.md

> Port: 8081 · Entry: `app/main.py` · Prefix: `/api/v1`

## Rules

- Chat link changes must verify both `stream=false` and `stream=true` paths
- Change schema/types first, then service and router
- Model structure changes must include Alembic migration
- Cross-service calls go through `app/services/*` — no hardcoded URLs or private implementation details

## Key Paths

| Area | Files |
|------|-------|
| Chat | `app/api/v1/chat.py` → `app/services/chat_service.py` |
| Orchestration | `app/runtime/supervisor/` |
| Tools | `app/runtime/tools/`, `app/services/tool_executor.py` |
| Streaming | `app/streaming/` |
| Schemas | `app/schemas/` |
| Models | `app/models/` |

## Constraints

- No `Any` in core interfaces
- No bare `dict` for business objects
- SSE chunk format and event order are stable API — do not break
- External addresses from `app/config.py` + `.env` only
- API input/output must be modeled in `app/schemas/*`

## Verify

```bash
# Static
poetry run mypy app && poetry run flake8 app && poetry run pytest

# Functional (requires running server)
ROADFX_CLI="node ../roadfx-cli/dist/index.js"
$ROADFX_CLI agent list --limit 1           # agent CRUD
$ROADFX_CLI provider list                  # provider connectivity
$ROADFX_CLI chat team --message "say ok"   # chat e2e (stream)

ROADFX_WIDGET_CLI="node ../roadfx-widget-cli/dist/index.js"
$ROADFX_WIDGET_CLI chat send --message "say ok" --no-stream  # visitor chat e2e
```
