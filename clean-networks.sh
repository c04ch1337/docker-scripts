#!/bin/bash
### Remove Only Networks ###
echo "🌐 Removing custom networks..."
docker network rm $(docker network ls -q --filter type=custom) 2>/dev/null || echo "No custom networks to remove"
echo "✅ Networks cleaned"
