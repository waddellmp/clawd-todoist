#!/bin/bash
# update.sh - Update a Todoist task
# Usage: update.sh task_id "new content" [priority]

TODOIST_API_TOKEN="$TODOIST_API_KEY"
API_BASE="https://api.todoist.com/rest/v2"

if [ -z "$TODOIST_API_TOKEN" ]; then
  echo "Error: TODOIST_API_KEY not set"
  exit 1
fi

TASK_ID="$1"
CONTENT="$2"
PRIORITY="${3:-}"

if [ -z "$TASK_ID" ]; then
  echo "Error: Task ID required"
  echo "Usage: update.sh task_id \"new content\" [priority]"
  exit 1
fi

# Build JSON payload
if [ -n "$CONTENT" ] && [ -n "$PRIORITY" ]; then
  DATA="{\"content\": \"$CONTENT\", \"priority\": $PRIORITY}"
elif [ -n "$CONTENT" ]; then
  DATA="{\"content\": \"$CONTENT\"}"
elif [ -n "$PRIORITY" ]; then
  DATA="{\"priority\": $PRIORITY}"
else
  echo "Error: At least one field to update (content or priority)"
  exit 1
fi

echo "Updating task $TASK_ID..."
curl -s -X POST "$API_BASE/tasks/$TASK_ID" \
  -H "Authorization: Bearer $TODOIST_API_TOKEN" \
  -H "Content-Type: application/json" \
  -d "$DATA" | jq '{
    id: .id,
    content: .content,
    priority: .priority,
    due_date: .due_date
  }'
