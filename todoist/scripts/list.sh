#!/bin/bash
# list.sh - List Todoist tasks
# Usage: list.sh [project_id] [filter]
# project_id: Optional project ID to filter by
# filter: Optional search query

TODOIST_API_TOKEN="$TODOIST_API_KEY"
API_BASE="https://api.todoist.com/rest/v2"

if [ -z "$TODOIST_API_TOKEN" ]; then
  echo "Error: TODOIST_API_KEY not set"
  exit 1
fi

URL="$API_BASE/tasks"

# Add project filter if provided
if [ -n "$1" ]; then
  URL="$URL?project_id=$1"
fi

# Add search filter if provided
if [ -n "$2" ]; then
  if [ -n "$1" ]; then
    URL="$URL&filter=$2"
  else
    URL="$URL?filter=$2"
  fi
fi

echo "Fetching tasks..."
curl -s -X GET "$URL" \
  -H "Authorization: Bearer $TODOIST_API_TOKEN" \
  -H "Content-Type: application/json" | jq -r 'map({id, content, priority, due_date: .due_date}) | .[] | "[\(if .priority == 4 then "!" else " " end)] \(.id) - \(.content) (\(.due_date // "no due date"))"' | head -20

echo ""
echo "Total tasks returned: $(curl -s -X GET "$URL" -H "Authorization: Bearer $TODOIST_API_TOKEN" -H "Content-Type: application/json" | jq 'length')"
