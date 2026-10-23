---
name: datadog
description: Analyze metrics, logs, or other data in Datadog. Use this skill when investigating issues or handling incidents
---

# Datadog Skill

## Prohibited Actions
- Never make any changes in Datadog
- Never display times without explicit timezone abbreviation
- Never assume external timestamps are in user's timezone (default assumption: UTC)

## Datadog CLI
Use `pup` to retrieve data from Datadog.

### Authentication
Requires either:
- OAuth2: `pup auth login`
- API keys: Set `DD_API_KEY` and `DD_APP_KEY` environment variables

### Global Flags
- `-o, --output`: Output format (json, table, yaml) - default: json
- `-y, --yes`: Skip confirmation prompts (auto-approve operations)

---

## APM (Application Performance Monitoring)

**Purpose**: Track services, operations, and dependencies for performance insights

### Distinction from Service Catalog
- **service-catalog**: Static metadata registry (ownership, definitions, documentation)
- **apm**: Dynamic operational data (performance stats, traces, runtime behavior)

### Capabilities
- List services with performance statistics (requests, errors, latency)
- Query entities with rich metadata (services, datastores, queues, inferred services)
- List operations and resources (endpoints) for services
- View service dependencies and flow maps with performance metrics

### Command Groups
```bash
pup apm services       # List and query APM services with performance data
pup apm entities       # Query APM entities (services, datastores, queues, etc.)
```

### Examples
```bash
# Query entities with filtering
pup apm entities list --start $(date -d '1 hour ago' +%s) --end $(date +%s) --env prod
```

---

## Logs

**Purpose**: Search and analyze log data with flexible queries and time ranges

### Capabilities
- Search logs with flexible queries (v1 API)
- Query and aggregate logs (v2 API)
- List logs with filtering (v2 API)
- Search across different storage tiers
- Manage log archives (CRUD operations)
- Manage custom destinations for logs
- Create and manage log-based metrics
- Configure restriction queries for access control

### Storage Tiers
- **indexes**: Standard indexed logs (default, real-time searchable)
- **online-archives**: Rehydrated logs from archives (slower queries, lower cost)
- **flex**: Flex logs (cost-optimized storage tier, balanced performance)

### Log Query Syntax
```
status:error                # Match by status
service:web-app            # Match by service
@user.id:12345             # Match by attribute
host:i-*                   # Wildcard matching
"exact phrase"             # Exact phrase matching
AND, OR, NOT               # Boolean operators
```

### Time Ranges
- **Relative**: 1h, 30m, 7d, 1w (hour, minute, day, week)
- **Absolute**: Unix timestamp in milliseconds
- **now**: Current time

### Command Groups
```bash
pup logs search              # Search logs (v1 API)
pup logs query               # Query logs (v2 API)
pup logs list                # List logs (v2 API)
pup logs aggregate           # Aggregate logs (v2 API)
pup logs archives            # Manage log archives
pup logs custom-destinations # Manage custom log destinations
pup logs metrics             # Manage log-based metrics
pup logs restriction-queries # Manage log restriction queries
```

### Examples
```bash
# Search for error logs in the last hour
pup logs search --query="status:error" --from="1h"

# Search Flex logs specifically
pup logs search --query="status:error" --from="1h" --storage="flex"

# Query logs from a specific service
pup logs query --query="service:web-app" --from="4h" --to="now"

# Query online archives
pup logs query --query="service:web-app" --from="30d" --storage="online-archives"

# Aggregate logs by status
pup logs aggregate --query="*" --compute="count" --group-by="status"

# List log archives
pup logs archives list

# List log-based metrics
pup logs metrics list
```

---

## Metrics

**Purpose**: Query time-series metrics, list available metrics, and manage metric metadata

### Capabilities
- Query time-series metrics data with flexible time ranges
- List all available metrics with optional filtering
- Get and update metric metadata (description, unit, type)
- Submit custom metrics to Datadog
- List metric tags and tag configurations

### Metric Types
- **gauge**: Point-in-time value (e.g., CPU usage, memory)
- **count**: Cumulative count (e.g., request count, errors)
- **rate**: Rate of change per second (e.g., requests per second)
- **distribution**: Statistical distribution (e.g., latency percentiles)

### Time Ranges
- **Relative**: 1h, 30m, 7d, 1w (hours, minutes, days, weeks)
- **Absolute**: Unix timestamps or ISO 8601 format
- **Special**: now (current time)

### Command Groups
```bash
pup metrics query     # Query time-series metrics data (v2 API)
pup metrics search    # Search metrics (v1 API)
pup metrics list      # List all available metrics
pup metrics metadata  # Manage metric metadata
pup metrics tags      # Manage metric tags
```

### Examples
```bash
# Query metrics
pup metrics query --query="avg:system.cpu.user{*}" --from="1h" --to="now"
pup metrics query --query="sum:app.requests{env:prod} by {service}" --from="4h"

# List metrics
pup metrics list
pup metrics list --filter="system.*"

# Get metric metadata
pup metrics metadata get system.cpu.user

# Update metric metadata
pup metrics metadata update system.cpu.user \
  --description="CPU user time" \
  --unit="percent" \
  --type="gauge"

# Submit custom metrics
pup metrics submit --name="custom.metric" --value=123 --tags="env:prod,team:backend"

# List metric tags
pup metrics tags list system.cpu.user --from="1h"
```

---

## Monitors

**Purpose**: Manage Datadog monitors for alerting and notifications

### Capabilities
- List all monitors with optional filtering by name or tags
- Get detailed information about a specific monitor
- Delete monitors (requires confirmation unless --yes flag is used)
- View monitor configuration, thresholds, and notification settings

### Monitor Types
- **metric alert**: Alert on metric threshold
- **log alert**: Alert on log query matches
- **trace-analytics alert**: Alert on APM trace patterns
- **composite**: Combine multiple monitors with boolean logic
- **service check**: Alert on service check status
- **event alert**: Alert on event patterns
- **process alert**: Alert on process status

### Command Groups
```bash
pup monitors list    # List monitors (limited results)
pup monitors search  # Search monitors
pup monitors get     # Get monitor details
pup monitors delete  # Delete a monitor
```

### Examples
```bash
# List all monitors
pup monitors list

# Filter monitors by name
pup monitors list --name="CPU"

# Filter monitors by tags
pup monitors list --tags="env:production,team:backend"

# Get detailed information about a specific monitor
pup monitors get 12345678
```

---

## Events

**Purpose**: Query and search Datadog events representing important occurrences in infrastructure

### What are Events?
Events represent important occurrences in your infrastructure such as:
- Deployments and releases
- Configuration changes
- Alert triggers and resolutions
- Custom events from applications
- Infrastructure changes (scaling, restarts, etc.)

### Capabilities
- List recent events with default time range
- Search events with custom queries and filters
- Get detailed information about specific events
- Filter by tags, sources, priority, and time ranges

### Search Parameters
- `--query`: Search query string (supports text search and filters)
- `--filter`: Additional filter query for refined results
- `--from`: Start time (Unix timestamp in seconds)
- `--to`: End time (Unix timestamp in seconds, defaults to now)
- `--limit`: Maximum number of results (default: 100)

### Command Groups
```bash
pup events list    # List recent events
pup events search  # Search events with queries and filters
pup events get     # Get event details by ID
```

### Examples
```bash
# Search for deployment events in the last hour
pup events search --query="tags:deployment" --from=$(date -d '1 hour ago' +%s) --to=$(date +%s)

# Search for events from a specific service in the last 24 hours
pup events search --query="service:web-app" --from=$(date -d '1 day ago' +%s)

# Search for high-priority events with limit
pup events search --query="priority:high" --limit=50 --from=$(date -d '24 hours ago' +%s)

# Search events within a specific time window (between 2 hours ago and 1 hour ago)
pup events search --query="source:kubernetes" --from=$(date -d '2 hours ago' +%s) --to=$(date -d '1 hour ago' +%s)

# Query deployment events for a specific namespace
pup events search --query="source:change_tracking kube_namespace:prod-navis @change_types:image" --from=$(date -d '2 hours ago' +%s)

# Query Monitor alerts
pup events search --query="source:alert status: error kube_namespace:prod-navis" --from=$(date -d '2 hours ago' +%s)

# Get details of a specific event
pup events get 1234567890

# Search for error-related events with additional filter
pup events search --query="error OR exception" --filter="env:production" --from=$(date -d '1 day ago' +%s)
```

### Common Event Sources
- **kubernetes**: K8s cluster events (pod restarts, deployments, scaling)
- **datadog**: Monitor alerts and state changes
- **change_tracking**: Deployment events
- **deployment_analysis**: Errors around deployments
- **alert**: State transition in Monitors including both recovering and error
