---
id: source-deploy
title: Source Deployment
sidebar_position: 1
---

# Source Deployment

This page explains how to build and deploy ROADFX from source code, suitable for customization or development debugging.

## Difference from Image Deployment

| Method | Description | Use Case |
|--------|-------------|----------|
| **Image Deployment** (default) | Uses pre-built Docker images | Production, quick deployment |
| **Source Deployment** | Builds images from local source | Development, customization |

## Source Deployment Steps

### 1. Clone Repository

```bash
git clone https://github.com/ivansslo/roadfx.git
cd roadfx
```

For users in China:

```bash
git clone https://gitee.com/ivansslo/roadfx.git
cd roadfx
```

### 2. Initialize Submodules

ROADFX service source code is managed as Git submodules in the `repos/` directory:

```bash
git submodule update --init --recursive
```

### 3. Run Source Installation

Use the `--source` parameter for source deployment:

```bash
./roadfx.sh install --source
```

For users in China, add `--cn` for mirrors:

```bash
./roadfx.sh install --source --cn
```

## Source Directory Structure

```
roadfx/
└── repos/
    ├── roadfx-api/        # Backend API service
    ├── roadfx-ai/         # AI inference service
    ├── roadfx-rag/        # RAG service
    ├── roadfx-platform/   # Platform management service
    ├── roadfx-web/        # Web console
    └── roadfx-widget/     # Widget component
```

## Build Specific Services

If you only modified one service, rebuild it individually:

```bash
# Build specific service
./roadfx.sh build api      # Build roadfx-api
./roadfx.sh build ai       # Build roadfx-ai
./roadfx.sh build rag      # Build roadfx-rag
./roadfx.sh build platform # Build roadfx-platform
./roadfx.sh build web      # Build roadfx-web
./roadfx.sh build widget   # Build roadfx-widget

# Build all services
./roadfx.sh build all
```

Restart services after building:

```bash
./roadfx.sh down
./roadfx.sh up --source
```

## Development Workflow

### Modify Code

1. Enter the service directory:
   ```bash
   cd repos/roadfx-api
   ```

2. Make your changes

3. Rebuild and restart:
   ```bash
   cd ../..
   ./roadfx.sh build api
   ./roadfx.sh down
   ./roadfx.sh up --source
   ```

### View Logs

```bash
# View all logs
docker compose logs -f

# View specific service logs
docker compose logs -f roadfx-api
```

### Enter Container for Debugging

```bash
docker compose exec roadfx-api bash
```

## Notes

1. **First build takes longer**: Source build requires downloading dependencies and compiling, may take 10-30 minutes initially

2. **Disk Space**: Source deployment requires more disk space for source code and build cache

3. **Network Requirements**: Build process needs to download dependency packages, ensure network connectivity

4. **Branch Sync**: If main repo is updated, remember to sync submodules:
   ```bash
   git pull
   git submodule update --recursive
   ```
