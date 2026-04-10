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

## Available Actions

### List tasks
GET /tasks

### Add task
POST /tasks with body: `{"content": "Task name", "priority": 1}`

### Update task
POST /tasks/{id} with body: `{"content": "Updated name"}`

### Delete task
DELETE /tasks/{id}

### Search tasks
GET /tasks?project_id={project_id}&filter={query}

## Setup

1. Get API token from https://todoist.com/prefs/integrations
2. Add to `~/.openclaw/openclaw.json` under `tools.todoist.apiKey`
