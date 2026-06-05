---
id: restart-upgrade
title: Restart and Upgrade
sidebar_position: 2
---

# Restart and Upgrade

This page explains how to manage ROADFX service start/stop and version upgrades.

## Service Management

### Start Services

```bash
./roadfx.sh up
```

Source mode:

```bash
./roadfx.sh up --source
```

### Stop Services

```bash
./roadfx.sh down
```

Stop and remove data volumes (**data will be lost**):

```bash
./roadfx.sh down --volumes
```

### Restart Services

```bash
./roadfx.sh down
./roadfx.sh up
```

### Restart Single Service

```bash
docker compose restart roadfx-api
```

## Version Upgrade

### Upgrade to Latest Version

```bash
./roadfx.sh upgrade
```

The `upgrade` command automatically:

1. Pulls latest code
2. Updates Docker images
3. Runs database migrations
4. Restarts all services

### Upgrade Command Options

```bash
./roadfx.sh upgrade [--source] [--cn]
```

| Option | Description |
|--------|-------------|
| `--source` | Build from source (instead of pre-built images) |
| `--cn` | Use China mirrors for acceleration |

### Install Mode Memory

`upgrade` remembers the mode used during initial installation. For example:

```bash
# Initial install with China mirrors
./roadfx.sh install --cn

# Subsequent upgrades auto-use --cn
./roadfx.sh upgrade
```

Configuration is saved in `./data/.roadfx-install-mode`.

## Uninstall

### Stop and Remove Services

```bash
./roadfx.sh uninstall
```

This command will:

1. Stop all containers
2. Remove containers
3. Ask whether to delete data

### Complete Cleanup

For complete cleanup of all data:

```bash
# Stop services
./roadfx.sh down --volumes

# Remove data directory
rm -rf ./data

# Remove config files
rm -f .env
rm -rf ./envs
```

## Backup and Restore

### Backup Data

Main data is stored in `./data` directory:

```bash
# Create backup
tar -czvf roadfx-backup-$(date +%Y%m%d).tar.gz ./data
```

### Restore Data

```bash
# Stop services
./roadfx.sh down

# Restore data
tar -xzvf roadfx-backup-20240101.tar.gz

# Start services
./roadfx.sh up
```

### Database Backup

Backup PostgreSQL database separately:

```bash
# Export database
docker compose exec postgres pg_dump -U roadfx tgo > roadfx-db-backup.sql

# Restore database
docker compose exec -T postgres psql -U roadfx tgo < roadfx-db-backup.sql
```

## Health Check

Check all service status:

```bash
./roadfx.sh doctor
```

Example output:

```
=========================================
  ROADFX Service Health Check
=========================================

  ✅ roadfx-api           running (healthy)
  ✅ roadfx-ai            running (healthy)
  ✅ roadfx-rag           running (healthy)
  ✅ roadfx-web           running
  ✅ postgres          running (healthy)
  ✅ redis             running (healthy)
  ✅ nginx             running

-----------------------------------------
Summary: 7/7 services healthy
```
