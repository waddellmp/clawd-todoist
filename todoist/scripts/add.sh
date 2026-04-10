#!/bin/bash
# add.sh - Add a Todoist task
# Usage: add.sh "Task content" [priority] [project_id]
# priority: 1-4 (4 = highest)
# project_id: Optional project ID

TODOIST_API_TOKEN="$TODOIST_API_KEY"
API_BASE="https://api.todoist.com/rest/v2"

if [ -z "$TODOIST_API_TOKEN" ]; then
  echo "Error: TODOIST_API_KEY not set"
  exit 1
fi

CONTENT="$1"
PRIORITY="${2:-4}"  # Default to priority 4 (highest)
PROJECT_ID="${3:-}"

if [ -z "$CONTENT" ]; then
  echo "Error: Task content required"
  echo "Usage: add.sh \"Task content\" [priority] [project_id]"
  exit 1
fi

DATA="{\"content\": \"$CONTENT\", \"priority\": $PRIORITY}"

if [ -n "$PROJECT_ID" ]; then
  DATA="{\"content\": \"$CONTENT\", \"priority\": $PRIORITY, \"project_id\": \"$PROJECT_ID\"}"
fi

echo "Adding task..."
curl -s -X POST "$API_BASE/tasks" \
  -H "Authorization: Bearer $TODOIST_API_TOKEN" \
  -H "Content-Type: application/json" \
  -d "$DATA" | jq '{
    id: .id,
    content: .content,
    priority: .priority,
    due_date: .due_date,
    created: .created
  }'
