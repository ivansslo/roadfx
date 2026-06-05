---
id: debug-tools
title: Debug Tools
sidebar_position: 3
---

# Debug Tools

ROADFX includes built-in debug tools to help you troubleshoot issues and monitor system status.

## Built-in Debug Tools

ROADFX provides the following debug tool containers:

| Tool | Purpose | Access URL |
|------|---------|------------|
| **Kafka UI** | Kafka message queue management interface | `http://localhost:8080` |
| **Adminer** | Database management interface | `http://localhost:8081` |

## Start Debug Tools

```bash
./roadfx.sh tools start
```

## Stop Debug Tools

```bash
./roadfx.sh tools stop
```

## Kafka UI

Kafka UI is a web interface for managing and monitoring Kafka clusters.

### Features

- View topic list
- Browse message content
- Monitor consumer groups
- View cluster status

### Use Cases

- Debug message send/receive issues
- Verify message content
- Monitor consumer lag

### Access

After starting tools, visit: `http://<server-ip>:8080`

## Adminer

Adminer is a lightweight database management tool.

### Features

- Browse database table structure
- Execute SQL queries
- Import/export data
- Edit table data

### Connection Info

| Parameter | Value |
|-----------|-------|
| System | PostgreSQL |
| Server | `postgres` |
| Username | `roadfx` (or check `POSTGRES_USER` in `.env`) |
| Password | `roadfx` (or check `POSTGRES_PASSWORD` in `.env`) |
| Database | `roadfx` (or check `POSTGRES_DB` in `.env`) |

### Access

After starting tools, visit: `http://<server-ip>:8081`

## View Logs

### View All Service Logs

```bash
docker compose logs -f
```

### View Specific Service Logs

```bash
docker compose logs -f roadfx-api
docker compose logs -f roadfx-ai
docker compose logs -f roadfx-rag
```

### View Last N Lines

```bash
docker compose logs --tail=100 roadfx-api
```

## Container Debugging

### Enter Container

```bash
docker compose exec roadfx-api bash
docker compose exec roadfx-ai bash
```

### Check Container Status

```bash
docker compose ps
```

### Check Resource Usage

```bash
docker stats
```

## Health Check

Use the `doctor` command for comprehensive health check:

```bash
./roadfx.sh doctor
```

This command checks:

- All service running status
- Database connection
- Nginx configuration
- Data directories
- API endpoint response

## Security Notes

:::warning Note
Debug tools are only for development and debugging environments. In production:

1. Don't expose debug tool ports to the public internet
2. Stop tools when done: `./roadfx.sh tools stop`
3. Change default database passwords
:::
