# roadfx-cli

ROADFX 客服系统的命令行工具，提供 **CLI** 和 **MCP Server** 双模式，让 AI Agent 能通过命令行或 MCP 协议执行与人类客服相同的操作。

## 快速开始

### 安装

```bash
cd repos/roadfx-cli
npm install
npm run build
```

或通过根目录 Makefile：

```bash
make install-cli
make build-cli
```

### 登录

```bash
# 登录并保存 token 到 ~/.roadfx/config.json
roadfx auth login -s http://localhost:8000/api -u admin@example.com -p yourpassword

# 验证登录
roadfx auth whoami
```

登录成功后，server 和 token 会自动保存，后续命令无需重复指定。

### 基本用法

```bash
# 查看等待队列
roadfx conversation list --scope waiting

# 接待访客
roadfx conversation accept <visitor-id>

# 发送消息
roadfx chat send --channel <channel-id> --type 251 --message "您好，有什么可以帮您？"

# 查看访客列表
roadfx visitor list --online --limit 10

# 关闭会话
roadfx conversation close <visitor-id>
```

## 全局选项

```
-s, --server <url>     API 服务器地址（优先级：CLI 参数 > ROADFX_SERVER 环境变量 > 配置文件）
-t, --token <token>    认证 token（优先级：CLI 参数 > ROADFXTOKEN 环境变量 > 配置文件）
-o, --output <format>  输出格式：json（默认）| table | compact
-v, --verbose          详细输出
```

## 命令参考

### auth - 认证

```bash
roadfx auth login -s <url> -u <user> -p <pass>   # 登录
roadfx auth logout                                 # 登出
roadfx auth whoami                                 # 当前用户信息
```

### conversation - 会话管理

```bash
roadfx conversation list [--scope mine|waiting|all] [--limit N] [--offset N]
roadfx conversation accept <visitor-id>
roadfx conversation transfer <visitor-id> --to <staff-id> [--reason <text>]
roadfx conversation close <visitor-id>
roadfx conversation waiting-count
```

别名：`roadfx conv`

### chat - 消息

```bash
roadfx chat send --channel <id> --type <N> --message <text>
roadfx chat agent --message <text> --agent <id>
roadfx chat clear-memory --channel <id> --type <N>
```

### visitor - 访客管理

```bash
roadfx visitor list [--online] [--search <q>] [--tag <id>] [--platform <id>] [--limit N]
roadfx visitor get <id>
roadfx visitor update <id> [--name <n>] [--email <e>] [--phone <p>] [--company <c>] [--note <text>]
roadfx visitor enable-ai <id>
roadfx visitor disable-ai <id>
```

### agent - AI Agent

```bash
roadfx agent list [--limit N] [--offset N]
roadfx agent get <id>
roadfx agent create --name <n> --model <m> [--instructions <text>] [--provider-id <id>]
roadfx agent update <id> [--name <n>] [--model <m>] [--instructions <text>]
roadfx agent delete <id>
```

### provider - AI 模型供应商

```bash
roadfx provider list
roadfx provider create --name <n> --provider <type> --api-key <key> [--api-base <url>]
roadfx provider test <id>
roadfx provider enable <id>
roadfx provider disable <id>
```

### knowledge - 知识库

```bash
roadfx knowledge list [--limit N] [--offset N]
roadfx knowledge get <id>
roadfx knowledge create --name <n> [--description <d>]
roadfx knowledge search <collection-id> --query <text> [--limit N]
roadfx knowledge upload <collection-id> <file-path>
roadfx knowledge delete <id>
```

别名：`roadfx kb`

### workflow - 工作流

```bash
roadfx workflow list [--limit N]
roadfx workflow get <id>
roadfx workflow execute <id> [--input <json>]
roadfx workflow validate <id>
```

别名：`roadfx wf`

### staff - 客服人员

```bash
roadfx staff list [--role <r>] [--status <s>] [--limit N]
roadfx staff get <id>
roadfx staff pause [<id>]       # 无 id 时暂停自己
roadfx staff resume [<id>]      # 无 id 时恢复自己
```

### platform / tag / system

```bash
roadfx platform list
roadfx platform get <id>

roadfx tag list [--category <cat>]
roadfx tag create --name <n> [--category <cat>] [--color <hex>]
roadfx tag delete <id>

roadfx system info
```

## 输出格式

```bash
# JSON（默认，AI Agent 友好）
roadfx visitor list -o json

# 表格（人类调试用）
roadfx staff list -o table

# 紧凑单行（快速浏览）
roadfx conversation list --scope waiting -o compact
```

## 环境变量

| 变量 | 说明 |
|------|------|
| `ROADFX_SERVER` | API 服务器地址 |
| `ROADFXTOKEN` | 认证 token |
| `ROADFXOUTPUT` | 默认输出格式 |

配置优先级：CLI 参数 > 环境变量 > `~/.roadfx/config.json`

## MCP Server 模式

roadfx-cli 内置 MCP Server，可让 Claude Code、Cursor 等 AI 工具直接调用客服系统 API。

### 启动

```bash
roadfx mcp serve
```

### Claude Code 配置

在项目的 `.mcp.json` 中添加：

```json
{
  "mcpServers": {
    "roadfx": {
      "command": "node",
      "args": ["/path/to/repos/roadfx-cli/bin/roadfx.js", "mcp", "serve"]
    }
  }
}
```

### 可用 Tools（40+）

| Tool | 说明 |
|------|------|
| `roadfx_auth_login` | 登录 |
| `roadfx_auth_whoami` | 当前用户 |
| `roadfx_conversation_list` | 会话列表 |
| `roadfx_conversation_accept` | 接待访客 |
| `roadfx_conversation_transfer` | 转接 |
| `roadfx_conversation_close` | 关闭会话 |
| `roadfx_conversation_waiting_count` | 等待数量 |
| `roadfx_chat_send` | 发送消息 |
| `roadfx_chat_agent` | 与 AI Agent 对话 |
| `roadfx_chat_clear_memory` | 清除 AI 记忆 |
| `roadfx_visitor_list` | 访客列表 |
| `roadfx_visitor_get` | 访客详情 |
| `roadfx_visitor_update` | 更新访客 |
| `roadfx_visitor_enable_ai` | 开启 AI |
| `roadfx_visitor_disable_ai` | 关闭 AI |
| `roadfx_agent_list` | Agent 列表 |
| `roadfx_agent_get` | Agent 详情 |
| `roadfx_agent_create` | 创建 Agent |
| `roadfx_agent_update` | 更新 Agent |
| `roadfx_agent_delete` | 删除 Agent |
| `roadfx_provider_list` | 供应商列表 |
| `roadfx_provider_create` | 创建供应商 |
| `roadfx_provider_test` | 测试连接 |
| `roadfx_provider_enable` | 启用供应商 |
| `roadfx_provider_disable` | 禁用供应商 |
| `roadfx_knowledge_list` | 知识库列表 |
| `roadfx_knowledge_get` | 知识库详情 |
| `roadfx_knowledge_create` | 创建知识库 |
| `roadfx_knowledge_search` | 知识库搜索 |
| `roadfx_knowledge_delete` | 删除知识库 |
| `roadfx_workflow_list` | 工作流列表 |
| `roadfx_workflow_get` | 工作流详情 |
| `roadfx_workflow_execute` | 执行工作流 |
| `roadfx_workflow_validate` | 验证工作流 |
| `roadfx_staff_list` | 人员列表 |
| `roadfx_staff_get` | 人员详情 |
| `roadfx_staff_pause` | 暂停接待 |
| `roadfx_staff_resume` | 恢复接待 |
| `roadfx_platform_list` | 平台列表 |
| `roadfx_platform_get` | 平台详情 |
| `roadfx_tag_list` | 标签列表 |
| `roadfx_tag_create` | 创建标签 |
| `roadfx_tag_delete` | 删除标签 |
| `roadfx_system_info` | 系统信息 |

## 典型工作流示例

### AI Agent 自动接待

```bash
# 1. 检查等待队列
roadfx conv waiting-count

# 2. 查看等待中的访客
roadfx conv list --scope waiting

# 3. 接待第一个访客
roadfx conv accept <visitor-id>

# 4. 查看访客信息
roadfx visitor get <visitor-id>

# 5. 发送欢迎消息
roadfx chat send --channel <channel-id> --type 251 --message "您好！请问有什么可以帮您？"

# 6. 需要时转接人工
roadfx conv transfer <visitor-id> --to <staff-id> --reason "客户要求人工服务"
```

### 管理 AI Agent 配置

```bash
# 查看所有 Agent
roadfx agent list

# 创建新 Agent
roadfx agent create --name "售后客服" --model "openai:gpt-4" \
  --instructions "你是一个专业的售后客服，负责处理退换货和投诉问题"

# 更新 Agent 指令
roadfx agent update <id> --instructions "新的指令内容"
```

### 知识库管理

```bash
# 创建知识库
roadfx kb create --name "产品文档" --description "所有产品的使用手册"

# 上传文档
roadfx kb upload <collection-id> ./docs/user-guide.pdf

# 搜索知识库
roadfx kb search <collection-id> --query "如何退货"
```

## 开发

```bash
# 安装依赖
npm install

# 开发模式（监听文件变化自动重新构建）
npm run dev

# 构建
npm run build

# 直接运行（开发时）
node bin/roadfx.js --help
```

## 项目结构

```
src/
├── index.ts            # CLI 入口（Commander）
├── client.ts           # HTTP API 客户端（fetch + auth + SSE）
├── config.ts           # 配置管理（~/.roadfx/config.json）
├── output.ts           # 输出格式化（json/table/compact）
├── commands/
│   ├── auth.ts         # 认证
│   ├── conversation.ts # 会话
│   ├── chat.ts         # 消息
│   ├── visitor.ts      # 访客
│   ├── agent.ts        # AI Agent
│   ├── provider.ts     # AI 供应商
│   ├── knowledge.ts    # 知识库
│   ├── workflow.ts     # 工作流
│   ├── staff.ts        # 客服人员
│   ├── platform.ts     # 平台
│   ├── tag.ts          # 标签
│   └── system.ts       # 系统
└── mcp/
    └── server.ts       # MCP Server（stdio）
```
