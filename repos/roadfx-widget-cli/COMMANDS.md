# roadfx-widget CLI Commands

## Global Options

```
-s, --server <url>     API server URL
-k, --api-key <key>    Platform API Key
-o, --output <format>  Output format: json (default) | table | compact
-v, --verbose          Verbose output
```

## Commands

### init

Register as a visitor and save configuration.

```bash
roadfx-widget init --api-key <key> --server <url> [--name <n>] [--email <e>] [--phone <p>]
```

### chat send

Send a message and get AI response (SSE streaming by default).

```bash
roadfx-widget chat send --message "Hello"
roadfx-widget chat send --message "Hello" --no-stream    # JSON response
```

### chat send-ws

Send a message via WuKongIM WebSocket (raw IM, no AI reply).

```bash
roadfx-widget chat send-ws --message "Hello"
```

### chat listen

Listen for incoming messages via WuKongIM WebSocket (JSONL output).

```bash
roadfx-widget chat listen
roadfx-widget chat listen --events    # Include custom events
```

### chat history

Get message history.

```bash
roadfx-widget chat history
roadfx-widget chat history --limit 50 --start-seq 100
```

### chat upload

Upload a file to the chat.

```bash
roadfx-widget chat upload /path/to/file.pdf
```

### platform info

Get platform information.

```bash
roadfx-widget platform info
```

### channel info

Get channel information.

```bash
roadfx-widget channel info
roadfx-widget channel info --channel-id <id> --channel-type 251
```

### activity record

Record a visitor activity.

```bash
roadfx-widget activity record --type page_view --title "Visited pricing page"
roadfx-widget activity record --type custom_event --title "Clicked CTA" --description "Hero section"
```

### whoami

Show current visitor configuration.

```bash
roadfx-widget whoami
```

### reset

Clear saved configuration.

```bash
roadfx-widget reset
```

### mcp serve

Start MCP Server (stdio transport).

```bash
roadfx-widget mcp serve
```

## MCP Tools

| Tool | Description |
|------|-------------|
| `roadfx_widget_init` | Register as visitor |
| `roadfx_widget_chat_send` | Send message + get AI response |
| `roadfx_widget_chat_send_ws` | Send via WebSocket (raw IM) |
| `roadfx_widget_chat_history` | Get message history |
| `roadfx_widget_chat_upload` | Upload a file |
| `roadfx_widget_platform_info` | Get platform info |
| `roadfx_widget_channel_info` | Get channel info |
| `roadfx_widget_activity_record` | Record visitor activity |
| `roadfx_widget_whoami` | Show current config |
| `roadfx_widget_reset` | Clear config |

## Environment Variables

| Variable | Description |
|----------|-------------|
| `ROADFXWIDGET_SERVER` | API server URL |
| `ROADFXWIDGET_API_KEY` | Platform API Key |
| `ROADFXWIDGET_OUTPUT` | Default output format |
| `ROADFXDEBUG` | Enable debug logging |

## Configuration

Config is stored at `~/.roadfx-widget/config.json` after running `init`:

```json
{
  "server": "http://localhost:8000/api",
  "api_key": "pk_...",
  "visitor_id": "...",
  "platform_open_id": "...",
  "channel_id": "...",
  "channel_type": 251,
  "im_token": "...",
  "platform_id": "..."
}
```
