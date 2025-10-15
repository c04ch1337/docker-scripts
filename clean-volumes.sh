#!/bin/bash
### Remove Only Volumes ###
echo "💾 Removing all volumes..."
docker volume rm $(docker volume ls -q) 2>/dev/null || echo "No volumes to remove"
echo "✅ Volumes cleaned"