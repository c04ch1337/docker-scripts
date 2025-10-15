#!/bin/bash
### Remove Only Images ###
echo "🖼️ Removing all images..."
docker rmi $(docker images -q) 2>/dev/null || echo "No images to remove"
echo "✅ Images cleaned"