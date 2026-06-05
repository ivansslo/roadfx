# roadfx-cli Command Reference

> **IMPORTANT**: This document must stay in sync with the source code.
> When adding, removing, or modifying any CLI command or MCP tool,
> update the corresponding section below.

## Global Options

| Flag | Description |
|------|-------------|
| `-s, --server <url>` | API server URL |
| `-t, --token <token>` | Auth token |
| `-o, --output <format>` | Output format: `json` (default), `table`, `compact` |
| `-v, --verbose` | Verbose output |

---

## CLI Commands

### auth

Source: `src/commands/auth.ts`

| Command | Description | Options / Arguments |
|---------|-------------|---------------------|
| `roadfx auth login` | Login and save token | `-u, --user <username>` (required), `-p, --pass <password>` (required) |
| `roadfx auth logout` | Clear saved token | — |
| `roadfx auth whoami` | Show current login info | — |

### conversation (alias: `conv`)

Source: `src/commands/conversation.ts`

| Command | Description | Options / Arguments |
|---------|-------------|---------------------|
| `roadfx conversation list` | List conversations | `--scope <mine\|waiting\|all>` (default: mine), `--limit <n>`, `--offset <n>`, `--msg-count <n>` |
| `roadfx conversation accept <visitor-id>` | Accept a visitor from waiting queue | `visitor-id` (required) |
| `roadfx conversation transfer <visitor-id>` | Transfer visitor to another staff | `visitor-id` (required), `--to <staff-id>` (required), `--reason <text>` |
| `roadfx conversation close <visitor-id>` | Close a visitor session | `visitor-id` (required) |
| `roadfx conversation waiting-count` | Get waiting queue count | — |

### chat

Source: `src/commands/chat.ts`

| Command | Description | Options / Arguments |
|---------|-------------|---------------------|
| `roadfx chat send` | Send message via WuKongIM WebSocket | `--channel <id>` (required), `--type <n>` (required), `--message <text>` (required) |
| `roadfx chat agent` | Chat with AI agent | `--message <text>` (required), `--agent <id>` (required) |
| `roadfx chat clear-memory` | Clear AI memory for a channel | `--channel <id>` (required), `--type <n>` (required) |
| `roadfx chat listen` | Listen for incoming messages (JSONL) | `--channel <id>`, `--events` |

### visitor

Source: `src/commands/visitor.ts`

| Command | Description | Options / Arguments |
|---------|-------------|---------------------|
| `roadfx visitor list` | List visitors | `--online`, `--search <q>`, `--tag <id>` (repeatable), `--platform <id>`, `--limit <n>`, `--offset <n>` |
| `roadfx visitor get <id>` | Get visitor details | `id` (required) |
| `roadfx visitor update <id>` | Update visitor attributes | `id` (required), `--name`, `--email`, `--phone`, `--company`, `--note` |
| `roadfx visitor enable-ai <id>` | Enable AI for visitor | `id` (required) |
| `roadfx visitor disable-ai <id>` | Disable AI for visitor | `id` (required) |

### agent

Source: `src/commands/agent.ts`

| Command | Description | Options / Arguments |
|---------|-------------|---------------------|
| `roadfx agent list` | List AI agents | `--limit <n>`, `--offset <n>` |
| `roadfx agent get <id>` | Get agent details | `id` (required) |
| `roadfx agent create` | Create a new AI agent | `--name <n>` (required), `--model <m>` (required), `--instructions <text>`, `--provider-id <id>` |
| `roadfx agent update <id>` | Update an AI agent | `id` (required), `--name`, `--model`, `--instructions` |
| `roadfx agent delete <id>` | Delete an AI agent | `id` (required) |

### provider

Source: `src/commands/provider.ts`

| Command | Description | Options / Arguments |
|---------|-------------|---------------------|
| `roadfx provider list` | List AI providers | — |
| `roadfx provider create` | Create a new AI provider | `--name <n>` (required), `--provider <type>` (required), `--api-key <key>` (required), `--api-base <url>` |
| `roadfx provider test <id>` | Test provider connection | `id` (required) |
| `roadfx provider enable <id>` | Enable a provider | `id` (required) |
| `roadfx provider disable <id>` | Disable a provider | `id` (required) |

### knowledge (alias: `kb`)

Source: `src/commands/knowledge.ts`

| Command | Description | Options / Arguments |
|---------|-------------|---------------------|
| `roadfx knowledge list` | List knowledge collections | `--limit <n>`, `--offset <n>` |
| `roadfx knowledge get <id>` | Get collection details | `id` (required) |
| `roadfx knowledge create` | Create a collection | `--name <n>` (required), `--description <d>` |
| `roadfx knowledge search <collection-id>` | Search documents | `collection-id` (required), `--query <text>` (required), `--limit <n>` |
| `roadfx knowledge upload <collection-id> <file>` | Upload a file | `collection-id` (required), `file` (required) |
| `roadfx knowledge delete <id>` | Delete a collection | `id` (required) |

### workflow (alias: `wf`)

Source: `src/commands/workflow.ts`

| Command | Description | Options / Arguments |
|---------|-------------|---------------------|
| `roadfx workflow list` | List workflows | `--limit <n>`, `--offset <n>` |
| `roadfx workflow get <id>` | Get workflow details | `id` (required) |
| `roadfx workflow execute <id>` | Execute a workflow | `id` (required), `--input <json>` |
| `roadfx workflow validate <id>` | Validate a workflow | `id` (required) |

### staff

Source: `src/commands/staff.ts`

| Command | Description | Options / Arguments |
|---------|-------------|---------------------|
| `roadfx staff list` | List staff members | `--role <r>`, `--status <s>`, `--limit <n>`, `--offset <n>` |
| `roadfx staff get <id>` | Get staff details | `id` (required) |
| `roadfx staff pause [id]` | Pause service (self if no ID) | `id` (optional) |
| `roadfx staff resume [id]` | Resume service (self if no ID) | `id` (optional) |

### platform

Source: `src/commands/platform.ts`

| Command | Description | Options / Arguments |
|---------|-------------|---------------------|
| `roadfx platform list` | List platforms | — |
| `roadfx platform get <id>` | Get platform details | `id` (required) |

### tag

Source: `src/commands/tag.ts`

| Command | Description | Options / Arguments |
|---------|-------------|---------------------|
| `roadfx tag list` | List tags | `--category <cat>` |
| `roadfx tag create` | Create a tag | `--name <n>` (required), `--category <cat>`, `--color <hex>` |
| `roadfx tag delete <id>` | Delete a tag | `id` (required) |

### system

Source: `src/commands/system.ts`

| Command | Description | Options / Arguments |
|---------|-------------|---------------------|
| `roadfx system info` | Get system information | — |

### mcp

Source: `src/index.ts`, `src/mcp/server.ts`

| Command | Description | Options / Arguments |
|---------|-------------|---------------------|
| `roadfx mcp serve` | Start MCP Server (stdio) | — |

---

## MCP Tools

Source: `src/mcp/server.ts`

Each tool is named `roadfx_<resource>_<action>` and maps to the corresponding CLI command.

| MCP Tool | Description | Parameters |
|----------|-------------|------------|
| `roadfx_auth_login` | Login to ROADFX and save token | `server` (string), `username` (string), `password` (string) |
| `roadfx_auth_logout` | Clear saved auth token | — |
| `roadfx_auth_whoami` | Get current logged-in user info | — |
| `roadfx_conversation_list` | List conversations | `scope` (mine/waiting/all), `limit`, `offset`, `msg_count` |
| `roadfx_conversation_accept` | Accept visitor from waiting queue | `visitor_id` (string) |
| `roadfx_conversation_transfer` | Transfer visitor to another staff | `visitor_id`, `target_staff_id`, `reason?` |
| `roadfx_conversation_close` | Close a visitor session | `visitor_id` (string) |
| `roadfx_conversation_waiting_count` | Get waiting queue count | — |
| `roadfx_chat_send` | Send message via WuKongIM WebSocket | `channel_id`, `channel_type` (number), `message` |
| `roadfx_chat_send_platform` | Send message via HTTP API (non-website) | `channel_id`, `channel_type` (number), `message` |
| `roadfx_chat_agent` | Chat with AI agent | `message`, `agent_id` |
| `roadfx_chat_clear_memory` | Clear AI memory for a channel | `channel_id`, `channel_type` (number) |
| `roadfx_visitor_list` | List visitors with filtering | `is_online?`, `search?`, `tag_ids?`, `platform_id?`, `limit`, `offset` |
| `roadfx_visitor_get` | Get visitor details | `id` (string) |
| `roadfx_visitor_update` | Update visitor attributes | `id`, `name?`, `email?`, `phone_number?`, `company?`, `note?` |
| `roadfx_visitor_enable_ai` | Enable AI for a visitor | `id` (string) |
| `roadfx_visitor_disable_ai` | Disable AI for a visitor | `id` (string) |
| `roadfx_agent_list` | List AI agents | `limit`, `offset` |
| `roadfx_agent_get` | Get AI agent details | `id` (string) |
| `roadfx_agent_create` | Create a new AI agent | `name`, `model`, `instruction?`, `ai_provider_id?` |
| `roadfx_agent_update` | Update an AI agent | `id`, `name?`, `model?`, `instruction?` |
| `roadfx_agent_delete` | Delete an AI agent | `id` (string) |
| `roadfx_provider_list` | List AI providers | — |
| `roadfx_provider_create` | Create a new AI provider | `name`, `provider_type`, `api_key`, `api_base?` |
| `roadfx_provider_test` | Test provider connection | `id` (string) |
| `roadfx_provider_enable` | Enable a provider | `id` (string) |
| `roadfx_provider_disable` | Disable a provider | `id` (string) |
| `roadfx_knowledge_list` | List knowledge collections | `limit`, `offset` |
| `roadfx_knowledge_get` | Get collection details | `id` (string) |
| `roadfx_knowledge_create` | Create a knowledge collection | `display_name`, `description?` |
| `roadfx_knowledge_search` | Search documents in collection | `collection_id`, `query`, `limit?` |
| `roadfx_knowledge_delete` | Delete a knowledge collection | `id` (string) |
| `roadfx_workflow_list` | List workflows | `limit`, `offset` |
| `roadfx_workflow_get` | Get workflow details | `id` (string) |
| `roadfx_workflow_execute` | Execute a workflow | `id`, `input?` (object) |
| `roadfx_workflow_validate` | Validate a workflow | `id` (string) |
| `roadfx_staff_list` | List staff members | `role?`, `status?`, `limit`, `offset` |
| `roadfx_staff_get` | Get staff member details | `id` (string) |
| `roadfx_staff_pause` | Pause service (self if no ID) | `id?` (string) |
| `roadfx_staff_resume` | Resume service (self if no ID) | `id?` (string) |
| `roadfx_platform_list` | List platforms | — |
| `roadfx_platform_get` | Get platform details | `id` (string) |
| `roadfx_tag_list` | List tags | `category?` |
| `roadfx_tag_create` | Create a tag | `name`, `category?`, `color?` |
| `roadfx_tag_delete` | Delete a tag | `id` (string) |
| `roadfx_system_info` | Get system information | — |

### CLI-only Commands (no MCP tool)

| Command | Reason |
|---------|--------|
| `roadfx chat listen` | Long-running process, not suitable for MCP request/response |
| `roadfx knowledge upload` | Requires local file path, not suitable for MCP |
| `roadfx mcp serve` | Starts the MCP server itself |
