#!/bin/bash
### Remove Only Containers ###
echo "🧹 Removing all containers..."
docker stop $(docker ps -aq) 2>/dev/null || echo "No containers to stop"
docker rm $(docker ps -aq) 2>/dev/null || echo "No containers to remove"
echo "✅ Containers cleaned"