#!/bin/bash
# delete.sh - Delete a Todoist task
# Usage: delete.sh task_id

TODOIST_API_TOKEN="$TODOIST_API_KEY"
API_BASE="https://api.todoist.com/rest/v2"

if [ -z "$TODOIST_API_TOKEN" ]; then
  echo "Error: TODOIST_API_KEY not set"
  exit 1
fi

TASK_ID="$1"

if [ -z "$TASK_ID" ]; then
  echo "Error: Task ID required"
  echo "Usage: delete.sh task_id"
  exit 1
fi

echo "Deleting task $TASK_ID..."
curl -s -X DELETE "$API_BASE/tasks/$TASK_ID" \
  -H "Authorization: Bearer $TODOIST_API_TOKEN" \
  -H "Content-Type: application/json" | jq '{
    success: (.id | length > 0)
  }'
