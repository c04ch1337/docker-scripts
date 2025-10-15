#!/bin/bash

set -e

echo "=================================================="
echo "🧹 DOCKER NUCLEAR RESET"
echo "=================================================="
echo "⚠️  WARNING: This will DELETE ALL Docker resources!"
echo "⚠️  Including: Containers, Images, Volumes, Networks"
echo "=================================================="

# Safety check
read -p "Are you sure you want to continue? (y/N): " -n 1 -r
echo
if [[ ! $REPLY =~ ^[Yy]$ ]]; then
    echo "❌ Operation cancelled"
    exit 1
fi

echo ""
echo "🚀 Starting nuclear cleanup..."

# Stop all running containers
echo "1. Stopping all containers..."
docker stop $(docker ps -aq) 2>/dev/null || echo "No containers to stop"

# Remove all containers
echo "2. Removing all containers..."
docker rm $(docker ps -aq) 2>/dev/null || echo "No containers to remove"

# Remove all images
echo "3. Removing all images..."
docker rmi $(docker images -q) 2>/dev/null || echo "No images to remove"

# Remove all volumes
echo "4. Removing all volumes..."
docker volume rm $(docker volume ls -q) 2>/dev/null || echo "No volumes to remove"

# Remove all networks (except defaults)
echo "5. Removing all custom networks..."
docker network rm $(docker network ls -q --filter type=custom) 2>/dev/null || echo "No custom networks to remove"

# Docker system prune (nuclear option)
echo "6. System prune (cleanup everything)..."
docker system prune -a --volumes -f

# Remove Docker Compose specific resources
echo "7. Cleaning Docker Compose resources..."
docker-compose down --rmi all --volumes --remove-orphans 2>/dev/null || echo "No compose projects"

# Final verification
echo ""
echo "✅ CLEANUP COMPLETE"
echo "=================================================="
echo "Remaining resources:"
echo "Containers: $(docker ps -aq | wc -l)"
echo "Images: $(docker images -q | wc -l)" 
echo "Volumes: $(docker volume ls -q | wc -l)"
echo "Networks: $(docker network ls -q | wc -l)"
echo "=================================================="

echo ""
echo "🎯 Next steps:"
echo "   Run: ./clean-project.sh (to clean specific project)"
echo "   Run: ./setup-fresh.sh (to start fresh setup)"