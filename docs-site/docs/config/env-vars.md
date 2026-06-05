---
id: env-vars
title: 环境变量
sidebar_position: 1
---

# 环境变量

ROADFX 使用环境变量来配置各项服务。本页介绍主要的配置文件和常用环境变量。

## 配置文件结构

ROADFX 的配置分为两层：

```
roadfx/
├── .env                    # 全局配置（端口、主机等）
└── envs/                   # 各服务独立配置
    ├── roadfx-api.env
    ├── roadfx-ai.env
    ├── roadfx-rag.env
    ├── roadfx-platform.env
    ├── roadfx-web.env
    ├── roadfx-widget-js.env
    └── wukongim.env
```

## 全局配置（.env）

根目录的 `.env` 文件包含全局配置：

| 变量 | 说明 | 默认值 |
|------|------|--------|
| `SERVER_HOST` | 服务器地址（IP 或域名） | 自动检测 |
| `VITE_API_BASE_URL` | 前端 API 地址 | `http://localhost` |
| `NGINX_PORT` | HTTP 端口 | `80` |
| `NGINX_SSL_PORT` | HTTPS 端口 | `443` |
| `POSTGRES_DB` | 数据库名 | `roadfx` |
| `POSTGRES_USER` | 数据库用户 | `roadfx` |
| `POSTGRES_PASSWORD` | 数据库密码 | `roadfx` |

### 修改全局配置

直接编辑 `.env` 文件：

```bash
vi .env
```

修改后需要重启服务：

```bash
./roadfx.sh down
./roadfx.sh up
```

## 服务配置（envs/）

### roadfx-api.env

API 服务配置：

| 变量 | 说明 | 默认值 |
|------|------|--------|
| `SECRET_KEY` | JWT 密钥（自动生成） | - |
| `PORT` | 服务端口 | `8000` |
| `REDIS_URL` | Redis 连接地址 | `redis://redis:6379/0` |
| `API_BASE_URL` | API 公开地址 | `http://localhost:8000` |
| `MAX_FILE_SIZE` | 最大文件上传大小 | `10485760` (10MB) |

### roadfx-ai.env

AI 服务配置：

| 变量 | 说明 | 默认值 |
|------|------|--------|
| `PORT` | 服务端口 | `8081` |
| `LOG_LEVEL` | 日志级别 | `DEBUG` |
| `API_SERVICE_URL` | API 服务地址 | `http://roadfx-api:8001` |
| `RAG_SERVICE_URL` | RAG 服务地址 | `http://roadfx-rag:8082` |
| `MCP_SERVICE_URL` | MCP 服务地址 | `http://roadfx-mcp-v4:8084` |

### roadfx-rag.env

RAG 服务配置：

| 变量 | 说明 |
|------|------|
| `EMBEDDING_MODEL` | 向量化模型配置 |
| `CHUNK_SIZE` | 文档分块大小 |
| `CHUNK_OVERLAP` | 分块重叠大小 |

### roadfx-web.env / roadfx-widget-js.env

前端应用配置：

| 变量 | 说明 |
|------|------|
| `VITE_API_BASE_URL` | API 地址 |
| `VITE_WS_URL` | WebSocket 地址 |

## WuKongIM 配置

即时通讯服务配置（在 `roadfx-api.env` 中）：

| 变量 | 说明 | 默认值 |
|------|------|--------|
| `WUKONGIM_SERVICE_URL` | WuKongIM 服务地址 | `http://wukongim:5001` |
| `WUKONGIM_ENABLED` | 是否启用 | `true` |

## 配置最佳实践

### 1. 不要直接修改 envs.docker/ 或 envs.example/

这些是模板目录。安装时会自动复制到 `envs/`，请只修改 `envs/` 中的文件。

### 2. SECRET_KEY 安全

`SECRET_KEY` 会在首次安装时自动生成。如需手动设置，确保：
- 长度至少 32 位
- 使用随机字符串
- 不要使用默认值

生成新密钥：

```bash
openssl rand -hex 32
```

### 3. 生产环境配置

生产环境建议修改以下配置：

```bash
# .env
POSTGRES_PASSWORD=<强密码>

# envs/roadfx-api.env
SECRET_KEY=<随机密钥>
LOG_LEVEL=INFO
```

### 4. 配置修改后重启

任何配置修改后都需要重启对应服务：

```bash
# 重启所有服务
./roadfx.sh down
./roadfx.sh up

# 或只重启特定服务
docker compose restart roadfx-api
```
