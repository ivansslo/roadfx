---
id: domain-ssl
title: Domain and SSL
sidebar_position: 2
---

# Domain and SSL Configuration

This page explains how to configure domains for Web / Widget / API services and enable HTTPS certificates.

## Configure Domains

ROADFX supports separate domains for different services:

| Service | Config Key | Example |
|---------|------------|---------|
| Web Console | `web_domain` | `www.example.com` |
| Widget Component | `widget_domain` | `widget.example.com` |
| API Service | `api_domain` | `api.example.com` |
| WebSocket | `ws_domain` | `ws.example.com` |

### Set Domains

Run in the repository root directory:

```bash
./roadfx.sh config web_domain www.example.com
./roadfx.sh config widget_domain widget.example.com
./roadfx.sh config api_domain api.example.com
./roadfx.sh config ws_domain ws.example.com
```

### Apply Configuration

After setting domains, run `apply` to activate:

```bash
./roadfx.sh config apply
```

This automatically generates/updates Nginx configuration to proxy different domains to their respective services.

### View Current Configuration

```bash
./roadfx.sh config show
```

## Enable HTTPS

ROADFX supports two SSL certificate configuration methods:

### Option A: Let's Encrypt Auto Certificate (Recommended)

**Prerequisites**:

- All domain DNS records point to your server's public IP
- Server ports 80/443 are accessible from the internet
- Server can access Let's Encrypt services

**Configuration Steps**:

```bash
# 1. Set certificate email (for expiration notices)
./roadfx.sh config ssl_email your-email@example.com

# 2. Request certificates
./roadfx.sh config setup_letsencrypt

# 3. Apply configuration
./roadfx.sh config apply
```

**Auto Renewal**:

Let's Encrypt certificates are valid for 90 days. Set up a cron job for auto-renewal:

```bash
# Edit crontab
crontab -e

# Add this line (check renewal daily at 2 AM)
0 2 * * * cd /path/to/roadfx && ./roadfx.sh config setup_letsencrypt >/dev/null 2>&1
```

### Option B: Use Existing Certificates

If you already have certificates from another CA:

```bash
# Install same certificate for all domains (wildcard certificate)
./roadfx.sh config ssl_manual /path/to/cert.pem /path/to/key.pem

# Or install certificate for specific domain
./roadfx.sh config ssl_manual /path/to/cert.pem /path/to/key.pem www.example.com

# Apply configuration
./roadfx.sh config apply
```

### Disable SSL

For HTTP-only access:

```bash
./roadfx.sh config ssl_mode none
./roadfx.sh config apply
```

## Complete Configuration Example

Here's a complete domain and SSL configuration workflow:

```bash
# 1. Configure domains
./roadfx.sh config web_domain www.example.com
./roadfx.sh config widget_domain widget.example.com
./roadfx.sh config api_domain api.example.com

# 2. Configure Let's Encrypt
./roadfx.sh config ssl_email admin@example.com
./roadfx.sh config setup_letsencrypt

# 3. Apply all configurations
./roadfx.sh config apply

# 4. View results
./roadfx.sh config show
```

After configuration, access via HTTPS:

- `https://www.example.com` - Web Console
- `https://widget.example.com` - Widget Component
- `https://api.example.com` - API Service
