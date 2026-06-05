---
id: roadfx-command
title: ROADFX Commands
sidebar_position: 4
---

# ROADFX Commands

`roadfx.sh` is the main management script for ROADFX providing all common commands for deployment, operations, and configuration.

## Command Overview

```bash
./roadfx.sh <command> [options]
```

## Basic Commands

### help

Display help information:

```bash
./roadfx.sh help
```

### install

First-time installation and start all services:

```bash
./roadfx.sh install [--source] [--cn]
```

| Option | Description |
|--------|-------------|
| `--source` | Build from source (instead of pre-built images) |
| `--cn` | Use China mirrors for acceleration |

Examples:

```bash
# Default install (using pre-built images)
./roadfx.sh install

# Source install
./roadfx.sh install --source

# Install with China mirrors
./roadfx.sh install --cn

# Combined options
./roadfx.sh install --source --cn
```

### up

Start all services (without initialization):

```bash
./roadfx.sh up [--source] [--cn]
```

Use after `down` to restart services.

### down

Stop and remove all containers:

```bash
./roadfx.sh down [--volumes]
```

| Option | Description |
|--------|-------------|
| `--volumes` | Also remove data volumes (**data will be lost**) |

### upgrade

Upgrade to latest version:

```bash
./roadfx.sh upgrade [--source] [--cn]
```

Automatically remembers the mode used during initial installation.

### doctor

Check health status of all services:

```bash
./roadfx.sh doctor
```

Output includes:

- Service running status
- Configuration checks
- Endpoint response tests

## Service Management Commands

### service

Manage core services:

```bash
./roadfx.sh service <start|stop|remove> [--source] [--cn]
```

| Subcommand | Description |
|------------|-------------|
| `start` | Start services |
| `stop` | Stop services |
| `remove` | Remove services |

### tools

Manage debug tools (Kafka UI, Adminer):

```bash
./roadfx.sh tools <start|stop>
```

| Subcommand | Description |
|------------|-------------|
| `start` | Start debug tools |
| `stop` | Stop debug tools |

### build

Build specific service from source:

```bash
./roadfx.sh build <service>
```

| Service | Description |
|---------|-------------|
| `api` | Build roadfx-api |
| `ai` | Build roadfx-ai |
| `rag` | Build roadfx-rag |
| `platform` | Build roadfx-platform |
| `web` | Build roadfx-web |
| `widget` | Build roadfx-widget |
| `all` | Build all services |

## Configuration Commands

### config

Domain and SSL certificate configuration:

```bash
./roadfx.sh config <subcommand> [args]
```

#### Domain Configuration

```bash
./roadfx.sh config web_domain <domain>      # Set Web domain
./roadfx.sh config widget_domain <domain>   # Set Widget domain
./roadfx.sh config api_domain <domain>      # Set API domain
./roadfx.sh config ws_domain <domain>       # Set WebSocket domain
```

#### SSL Configuration

```bash
./roadfx.sh config ssl_mode <auto|manual|none>   # Set SSL mode
./roadfx.sh config ssl_email <email>              # Set Let's Encrypt email
./roadfx.sh config ssl_manual <cert> <key> [domain]  # Install manual certificate
./roadfx.sh config setup_letsencrypt              # Request Let's Encrypt certificates
```

#### Other Config Commands

```bash
./roadfx.sh config apply   # Apply config (regenerate Nginx config)
./roadfx.sh config show    # Show current configuration
```

## Environment Variables

The one-click installation script supports these environment variables:

| Variable | Description | Default |
|----------|-------------|---------|
| `REF` | Deploy version (branch/tag/commit) | `latest` |
| `DIR` | Installation directory | `./roadfx` |

Example:

```bash
REF=v1.0.0 DIR=/opt/roadfx curl -fsSL https://raw.githubusercontent.com/ivansslo/roadfx/main/bootstrap.sh | bash
```

## Configuration Files

| File | Description |
|------|-------------|
| `.env` | Global environment variables |
| `envs/*.env` | Service environment variables |
| `data/.roadfx-install-mode` | Install mode memory |
| `data/.roadfx-domain-config` | Domain and SSL config |

## Data Directories

| Directory | Description |
|-----------|-------------|
| `data/postgres/` | PostgreSQL data |
| `data/redis/` | Redis data |
| `data/wukongim/` | WuKongIM data |
| `data/nginx/` | Nginx config and certificates |
| `data/uploads/` | Uploaded files |

## Usage Recommendations

1. **Production**: Use `./roadfx.sh install` with default image deployment
2. **Development**: Use `./roadfx.sh install --source` for source deployment
3. **China servers**: Add `--cn` for acceleration
4. **Troubleshooting**: Run `./roadfx.sh doctor` first to check status
