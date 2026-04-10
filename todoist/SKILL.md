---
name: todoist
description: "Manage Todoist tasks via the Todoist REST API. Use when a user asks OpenClaw to add, list, search, or update Todoist tasks."
metadata: { "openclaw": { "emoji": "✅", "requires": { "config": ["tools.todoist.apiKey"] } } }
allowed-tools: ["exec"]
---

# Todoist (Via API)

Use the Todoist REST API to manage tasks.

## Musts

- Always: Use `https://api.todoist.com/rest/v2/` as the base URL
- Always: Include `Authorization: Bearer <api_key>` header
- Always: Use `application/json` content type

## Available Scripts

### List tasks
`scripts/list.sh [project_id] [filter]`
- Lists all tasks or filters by project ID and/or search query
- Shows task ID, content, priority, and due date

### Add task
`scripts/add.sh "Task content" [priority] [project_id]`
- Add a new task with priority 1-4 (4 = highest)
- Optional project ID to assign to a project

### Update task
`scripts/update.sh task_id "new content" [priority]`
- Update task content and/or priority
- Only one field needs to be provided

### Delete task
`scripts/delete.sh task_id`
- Permanently delete a task by ID

### Search tasks
Use `scripts/list.sh` with project ID and/or filter arguments

## Setup

1. Get API token from https://todoist.com/prefs/integrations
2. Add to `~/.openclaw/openclaw.json`:
```json
{
  "tools": {
    "todoist": {
      "apiKey": "YOUR_TODOIST_API_TOKEN"
    }
  }
}
```
3. Install the skill: `openclaw skills install waddellmp/clawd-todoist`

## Example Usage

```bash
# List all tasks
scripts/list.sh

# List tasks in project
scripts/list.sh 1234567890

# List tasks with filter
scripts/list.sh "" "today"

# Add a task
scripts/add.sh "Buy groceries" 4

# Add a task to project
scripts/add.sh "Write report" 3 "987654321"

# Update a task
scripts/update.sh 1111111111 "Updated task name"

# Delete a task
scripts/delete.sh 1111111111
```

## Environment Variables

- `TODOIST_API_KEY`: Your Todoist API token (required)
